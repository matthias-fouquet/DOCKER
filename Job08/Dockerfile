# ==============================================================================
# Job 08 : Conteneur Nginx construit à partir d'une image Debian (sans image Nginx)
# ==============================================================================

# Image de base Debian minimale
FROM debian:bookworm-slim

# Mise à jour des dépôts, installation de Nginx et nettoyage du cache APT
# --no-install-recommends évite d'installer les dépendances graphiques ou superflues
RUN apt-get update \
    && apt-get install -y --no-install-recommends nginx \
    && rm -rf /var/lib/apt/lists/*

# Copie de notre page Web locale dans le répertoire racine par défaut de Nginx
COPY index.html /var/www/html/index.html

# Documentation du port d'écoute HTTP standard
EXPOSE 80

# Démarrage de Nginx au premier plan pour maintenir le conteneur en vie (PID 1)
# Sans "daemon off;", Nginx part en arrière-plan et le conteneur s'arrête immédiatement
CMD ["nginx", "-g", "daemon off;"]