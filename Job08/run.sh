#!/bin/bash
# ==============================================================================
# Job 08 : Build de l'image Nginx personnalisée et test d'accès
# ==============================================================================

# Arrêt du script en cas d'erreur
set -e

echo "=== 1. Construction de l'image personnalisée (my-nginx) ==="
# 'docker build' génère l'image 'my-nginx' depuis le Dockerfile du dossier courant
docker build -t my-nginx .

echo ""
echo "=== 2. Lancement du conteneur Nginx en arrière-plan ==="
# Nettoyage d'un éventuel conteneur nommé 'web' existant
docker rm -f web 2>/dev/null || true

# -d : exécution en tâche de fond
# --name web : nom explicite du conteneur
# -p 8081:80 : lie le port 8081 de l'hôte au port 80 interne de Nginx
docker run -d --name web -p 8081:80 my-nginx

echo ""
echo "=== 3. Vérification du statut du conteneur ==="
docker ps --filter "name=web"

echo ""
echo "=== 4. Test de la réponse HTTP sur le port 8081 ==="
# Requête HTTP locale sur le port exposé pour valider l'affichage
curl -s http://localhost:8081

echo ""
echo "Job 08 validé avec succès."