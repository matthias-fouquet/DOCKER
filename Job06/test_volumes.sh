#!/bin/bash
# ==============================================================================
# Job 06 : Démonstration et gestion des volumes partagés entre conteneurs
# ==============================================================================

# Interrompt le script en cas d'erreur
set -e

echo "=== 1. Création d'un volume nommé managé par Docker ==="
# 'docker volume create' alloue un espace persistant sur l'hôte (/var/lib/docker/volumes/)
docker volume create data

echo ""
echo "=== 2. Inspection du volume créé ==="
# Confirme la création et affiche les métadonnées (point de montage hôte)
docker volume ls --filter "name=data"
docker volume inspect data

echo ""
echo "=== 3. Lancement de deux conteneurs partageant le même volume ==="
# Nettoyage préventif si les conteneurs existent déjà
docker rm -f c1 c2 2>/dev/null || true

# Lancement de c1 : monte le volume 'data' sur le point de montage interne '/shared'
# 'sleep 3600' permet de maintenir le conteneur en arrière-plan pendant les tests
docker run -d --name c1 -v data:/shared alpine sleep 3600

# Lancement de c2 : monte exactement le même volume 'data' sur son propre '/shared'
docker run -d --name c2 -v data:/shared alpine sleep 3600

echo ""
echo "=== 4. Écriture d'un fichier depuis le conteneur c1 ==="
# 'docker exec' exécute une commande à l'intérieur du conteneur actif c1
# On crée un fichier f.txt avec le mot 'salut' dans le dossier partagé /shared
docker exec c1 sh -c 'echo salut > /shared/f.txt'

echo ""
echo "=== 5. Lecture du fichier depuis le conteneur c2 ==="
# Le conteneur c2 lit le fichier écrit par c1 : cela prouve le partage de données via le volume
RESULTAT=$(docker exec c2 cat /shared/f.txt)
echo "Contenu lu par le conteneur c2 : $RESULTAT"

if [ "$RESULTAT" = "salut" ]; then
  echo "=> Succès : la persistance et le partage inter-conteneurs fonctionnent."
else
  echo "=> Échec du test de partage de volume."
  exit 1
fi

echo ""
echo "=== 6. Nettoyage des conteneurs et du volume de test ==="
# Arrêt et suppression forcée des conteneurs de test
docker rm -f c1 c2
# Suppression du volume nommé
docker volume rm data

echo ""
echo "Job 06 validé avec succès."