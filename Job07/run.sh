#!/bin/bash
# ==============================================================================
# Job 07 : Script de démarrage, injection de la page de test et vérification
# ==============================================================================

# Interrompt le script en cas d'erreur
set -e

echo "=== 1. Démarrage des conteneurs avec Docker Compose ==="
# 'docker compose up -d' lit le docker-compose.yml local et lance les services en arrière-plan
docker compose up -d

echo ""
echo "=== 2. Injection de la page HTML initiale dans le volume partagé ==="
# 'docker cp' copie directement index.html dans le répertoire servi par Nginx
# Comme le volume est partagé, ce fichier apparaît également dans le dossier FTP
docker cp index.html job07-web:/usr/share/nginx/html/index.html

echo ""
echo "=== 3. Vérification de l'état des conteneurs ==="
# Confirme que les deux services sont bien actifs (statut Up)
docker compose ps

echo ""
echo "=== 4. Test de la réponse HTTP sur le port 8080 ==="
# Effectue une requête HTTP locale sur le port redirigé de Nginx
curl -s http://localhost:8080 | head -n 10

echo ""
echo "=== 5. Informations pour la connexion FTP ==="
echo "Hôte     : localhost (ou AppleManDOCKER.local depuis le Mac)"
echo "Port     : 21"
echo "Login    : matthias"
echo "Pass     : password123"
echo ""
echo "Job 07 configuré et actif."