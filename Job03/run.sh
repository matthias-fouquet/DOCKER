#!/bin/bash
# ==============================================================================
# Job 03 : Build et exécution de l'image Dockerfile
# ==============================================================================

# Interrompt le script en cas d'erreur
set -e

echo "=== 1. Construction de l'image locale (Build) ==="
# 'docker build' lit le Dockerfile dans le répertoire courant (.)
# -t (tag) : donne un nom d'identification lisible à l'image construite
docker build -t hello-debian .

echo ""
echo "=== 2. Vérification de l'image créée dans le cache local ==="
# Confirme la présence de la nouvelle image et affiche sa taille optimisée
docker images hello-debian

echo ""
echo "=== 3. Instanciation et exécution du conteneur ==="
# 'docker run' crée et démarre un conteneur basé sur hello-debian[span_11]
# --rm : détruit automatiquement le conteneur dès que la commande CMD se termine pour ne rien polluer
docker run --rm hello-debian

echo ""
echo "Job 03 validé avec succès."
