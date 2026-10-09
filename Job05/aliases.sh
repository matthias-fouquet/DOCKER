# ==============================================================================
# Job 05 : Alias Docker pour ~/.bashrc
# ==============================================================================

# Raccourci vers la binaire Docker de base
alias d='docker'

# Visualisation des conteneurs
alias dps='docker ps'                         # Liste uniquement les conteneurs actifs
alias dpa='docker ps -a'                      # Liste tous les conteneurs (actifs et arrêtés)

# Gestion des images locales
alias di='docker images'                      # Liste les images stockées localement

# Exécution et interaction
alias dr='docker run -d'                      # Lance un conteneur en arrière-plan
alias dex='docker exec -it'                   # Ouvre un terminal interactif dans un conteneur actif

# Inspection et logs
alias dl='docker logs -f'                     # Suit les logs d'un conteneur en temps réel

# Docker Compose
alias dc='docker compose'                     # Raccourci pour docker compose v2

# Arrêt et nettoyage de masse (les commandes $(...) sont évaluées à l'exécution)
alias dstop='docker stop $(docker ps -q)'     # Arrête tous les conteneurs en cours d'exécution
alias drm='docker rm $(docker ps -aq)'        # Supprime tous les conteneurs arrêtés
alias drmi='docker rmi $(docker images -q)'   # Supprime toutes les images locales
alias dprune='docker system prune -af'        # Purge conteneurs, images non utilisées et réseaux inutilisés