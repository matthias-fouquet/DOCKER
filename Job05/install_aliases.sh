#!/bin/bash
# ==============================================================================
# Job 05 : Script d'injection des alias dans ~/.bashrc
# ==============================================================================

set -e

BASHRC_FILE="$HOME/.bashrc"
MARKER="# === DOCKER ALIASES JOB 05 ==="

echo "=== 1. Vérification de la présence des alias dans ~/.bashrc ==="
# Évite d'ajouter plusieurs fois le bloc d'alias en cas de réexécution
if grep -Fxq "$MARKER" "$BASHRC_FILE" 2>/dev/null; then
  echo "Les alias Docker sont déjà configurés dans $BASHRC_FILE."
else
  echo "=== 2. Ajout des alias en fin de ~/.bashrc ==="
  cat << 'EOF' >> "$BASHRC_FILE"

# === DOCKER ALIASES JOB 05 ===
alias d='docker'
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dr='docker run -d'
alias dex='docker exec -it'
alias dl='docker logs -f'
alias dc='docker compose'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dprune='docker system prune -af'
# === FIN DOCKER ALIASES ===
EOF
  echo "Alias ajoutés avec succès."
fi

echo ""
echo "=== 3. Rechargement du fichier de configuration ==="
# Charge les alias dans la session en cours
# shellcheck source=/dev/null
source "$BASHRC_FILE"

echo "=== 4. Test d'un alias ==="
# Teste l'alias dps
dps

echo ""
echo "Job 05 validé avec succès."