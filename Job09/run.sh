#!/bin/bash
# ==============================================================================
# Job 09 : Déploiement du registre, publication d'image et test d'API
# ==============================================================================

# Interrompt le script en cas d'erreur
set -e

echo "=== 1. Démarrage du registre et de son interface Web ==="
# Lance le registre et l'interface Web en arrière-plan
docker compose up -d

echo ""
echo "=== 2. Tag de l'image locale pour le registre privé ==="
# Attribue un alias pointant vers le serveur local (localhost:5000)
# On utilise l'image ssh-debian (Job 04) ou mon-ssh selon le tag disponible
docker tag ssh-debian localhost:5000/ssh-debian 2>/dev/null || docker tag mon-ssh localhost:5000/ssh-debian

echo ""
echo "=== 3. Envoi (Push) de l'image vers le registre local ==="
# Pousse les couches de l'image vers le port 5000 du conteneur registry
docker push localhost:5000/ssh-debian

echo ""
echo "=== 4. Vérification du catalogue via l'API REST v2 ==="
# Interroge le point d'entrée HTTP du catalogue pour confirmer l'enregistrement
curl -s http://localhost:5000/v2/_catalog

echo ""
echo ""
echo "=== 5. Accès Web ==="
echo "Interface disponible sur : http://AppleManDOCKER.local:8082"
echo "Job 09 validé avec succès."