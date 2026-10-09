# ==============================================================================
# Job 04 : Image personnalisée pour serveur OpenSSH
# ==============================================================================

# Image de base Debian minimale
FROM debian:bookworm-slim

# Installation et configuration du service SSH en une seule couche RUN :
# 1. apt-get update : actualise les index des dépôts
# 2. apt-get install : installe le paquet openssh-server sans paquets recommandés superflus
# 3. rm -rf /var/lib/apt/lists/* : purge le cache APT pour alléger l'image finale
# 4. mkdir -p /run/sshd : garantit l'existence du dossier de socket pour le démon sshd
# 5. echo 'root:root123' | chpasswd : fixe le mot de passe du compte root
# 6. sed : autorise explicitement la connexion root par mot de passe dans sshd_config
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd \
    && echo 'root:root123' | chpasswd \
    && sed -i 's/#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Documente le port réseau d'écoute interne du service dans le conteneur
EXPOSE 22

# Démarre le démon SSH au premier plan (-D) pour maintenir le conteneur en vie (PID 1)
CMD ["/usr/sbin/sshd", "-D"]