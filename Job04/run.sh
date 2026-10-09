#!/bin/bash
# ==============================================================================
# Job 04 : Build, instanciation et test d'accès SSH
# ==============================================================================

set -e

echo "=== 1. Construction de l'image SSH personnalisée ==="
# Construit l'image locale avec le tag 'ssh-debian' depuis le Dockerfile local
docker build -t ssh-debian .

echo ""
echo "=== 2. Lancement du conteneur en arrière-plan ==="
# Nettoie un éventuel conteneur nommé 'conteneur-ssh' déjà existant
docker rm -f conteneur-ssh 2>/dev/null || true

# -d : détache l'exécution en tâche de fond
# --name : nomme le conteneur pour l'administrer facilement
# -p 2222:22 : redirige le port 2222 de l'hôte vers le port 22 du conteneur
docker run -d --name conteneur-ssh -p 2222:22 ssh-debian

echo ""
echo "=== 3. Vérification du statut et de la redirection des ports ==="
docker ps --filter "name=conteneur-ssh"

echo ""
echo "=== 4. Test de connexion SSH ==="
echo "Pour vous connecter au conteneur, exécutez la commande suivante :"
echo "ssh root@localhost -p 2222"
echo "(Mot de passe requis : root123)"