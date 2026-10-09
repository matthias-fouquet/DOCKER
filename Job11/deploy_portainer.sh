#!/bin/bash
# ==============================================================================
# Job 11 : Déploiement automatisé de Portainer Community Edition
# Auteur : Matthias FOUQUET
# Objectif : Créer un volume persistant et lancer le conteneur Portainer CE
#            avec accès au socket Docker local et redirection des ports.
# ==============================================================================

# Arrêt du script en cas d'erreur
set -e

echo "=== 1. Création du volume persistant pour les données de Portainer ==="
# Stocke la base de données interne de Portainer (comptes, configurations, tokens)
docker volume create portainer_data

echo ""
echo "=== 2. Nettoyage préventif d'une ancienne instance ==="
docker rm -f portainer 2>/dev/null || true

echo ""
echo "=== 3. Lancement du conteneur Portainer CE ==="
# -p 8000:8000 : port requis pour le tunnel Edge Agent
# -p 9443:9443 : port d'écoute sécurisé HTTPS pour l'interface d'administration
# -v /var/run/docker.sock : donne les privilèges à Portainer pour piloter dockerd
# -v portainer_data:/data : assure la persistance des paramètres sur le disque hôte
# --restart=always : relance automatiquement Portainer au boot de la machine
docker run -d --name portainer \
  --restart=always \
  -p 8000:8000 \
  -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo ""
echo "=== 4. Vérification de l'état du conteneur ==="
docker ps --filter "name=portainer"

echo ""
echo "=== Portainer déployé avec succès ==="
echo "Accès Web : https://AppleManDOCKER.local:9443 (ou https://<IP_VM>:9443)"