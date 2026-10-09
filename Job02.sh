#!/bin/bash
# ==============================================================================
# Job 02 : Test d'installation et commandes de base Docker CLI
# ==============================================================================

# Arrête le script dès qu'une erreur inattendue survient
set -e

echo "=== 1. Test du démon Docker avec le conteneur hello-world ==="
# Télécharge l'image depuis Docker Hub si absente, crée le conteneur,
# exécute le binaire affichant le message officiel, puis quitte le processus.
docker run hello-world

echo ""
echo "=== 2. Consultation des conteneurs en cours d'exécution ==="
# Affiche uniquement les conteneurs actifs (le conteneur hello-world n'apparaît pas
# car son processus PID 1 s'est terminé avec succès).
docker ps

echo ""
echo "=== 3. Consultation de tous les conteneurs (actifs et arrêtés) ==="
# L'option -a (all) liste tous les conteneurs présents sur le système.
# Permet de vérifier que hello-world s'est arrêté proprement avec le code de sortie 0 : Exited (0).
docker ps -a

echo ""
echo "=== 4. Consultation des images locales ==="
# Liste les images téléchargées ou construites localement sur la machine hôte.
# Permet de vérifier la présence de l'image 'hello-world:latest' et sa taille.
docker images

echo ""
echo "=== 5. Inspection des logs d'un conteneur ==="
# Récupère l'identifiant du dernier conteneur exécuté (option -l pour latest, -q pour quiet/ID seul)
LAST_CONTAINER_ID=$(docker ps -lq)
# Affiche la sortie standard et d'erreur générée par le conteneur lors de son cycle de vie
docker logs "$LAST_CONTAINER_ID"

echo ""
echo "=== 6. Nettoyage : suppression du conteneur de test ==="
# Supprime le conteneur arrêté identifié par son ID pour libérer la couche d'écriture
docker rm "$LAST_CONTAINER_ID"

echo ""
echo "=== 7. Nettoyage : suppression de l'image hello-world ==="
# 'rmi' (remove image) supprime l'image du cache local de la VM
docker rmi hello-world

echo ""
echo "Vérification finale après nettoyage :"
docker ps -a
docker images

echo "Job 02 validé avec succès."