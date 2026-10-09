#!/bin/bash
# ==============================================================================
# Job 03 : Build et exécution de l'image Dockerfile
# ==============================================================================

# Interrompt le script en cas d'erreur
set -e

echo "=== 1. Construction de l'image locale (Build) ==="
# 'docker build' lit le Dockerfile dans le répertoire courant (.)[span_8](start_span)[span_8](end_span)[span_9](start_span)[span_9](end_span)
# -t (tag) : donne un nom d'identification lisible à l'image construite[span_10](start_span)[span_10](end_span)
docker build -t hello-debian .

echo ""
echo "=== 2. Vérification de l'image créée dans le cache local ==="
# Confirme la présence de la nouvelle image et affiche sa taille optimisée
docker images hello-debian

echo ""
echo "=== 3. Instanciation et exécution du conteneur ==="
# 'docker run' crée et démarre un conteneur basé sur hello-debian[span_11](start_span)[span_11](end_span)[span_12](start_span)[span_12](end_span)
# --rm : détruit automatiquement le conteneur dès que la commande CMD se termine pour ne rien polluer[span_13](start_span)[span_13](end_span)
docker run --rm hello-debian

echo ""
echo "Job 03 validé avec succès."