#!/bin/bash
# ==============================================================================
# Job 01 : Installation de Docker Engine et Docker CLI sur Debian
# VM : Mode console, 8 Go DD, 1 Go RAM, 1 vCPU
# ==============================================================================

# Arrêter l'exécution immédiatement si une commande échoue
set -e

# Vérifier que le script est bien lancé avec les privilèges administrateur (root)
if [ "$EUID" -ne 0 ]; then
  echo "Erreur : ce script doit être exécuté en tant que root ou avec sudo."
  exit 1
fi

echo "=== 1. Mise à jour de la liste des paquets existants ==="
# Met à jour les index des dépôts système pour connaître les dernières versions disponibles
apt-get update

echo "=== 2. Installation des dépendances pour HTTPS et la gestion des certificats ==="
# ca-certificates : permet de vérifier les certificats SSL lors des téléchargements sécurisés
# curl : utilitaire pour télécharger des fichiers depuis le web (clé GPG, etc.)
apt-get install -y ca-certificates curl

echo "=== 3. Création du répertoire sécurisé pour les clés de signature APT ==="
# -m 0755 : définit les permissions de lecture/exécution pour tout le monde, écriture pour root
# -d : crée le dossier s'il n'existe pas déjà
install -m 0755 -d /etc/apt/keyrings

echo "=== 4. Téléchargement et ajout de la clé GPG officielle de Docker ==="
# Récupère la clé de signature publique de Docker pour garantir l'authenticité des paquets téléchargés
# -f : échoue silencieusement si la page HTTP n'existe pas (erreur 404)
# -s : mode silencieux (n'affiche pas la barre de progression)
# -S : affiche les erreurs si le téléchargement échoue
# -o : définit le fichier de destination où écrire la clé
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Ajuste les permissions pour que le gestionnaire de paquets puisse lire la clé GPG
chmod a+r /etc/apt/keyrings/docker.asc

echo "=== 5. Ajout du dépôt officiel Docker aux sources APT ==="
# Récupère les informations système (comme la version de Debian : bookworm, bullseye...)
. /etc/os-release

# Ajoute l'URL du dépôt officiel Docker dans la liste des sources logicielles d'APT
# signed-by : force APT à valider les paquets de ce dépôt uniquement avec la clé téléchargée plus haut
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $VERSION_CODENAME stable" > /etc/apt/sources.list.d/docker.list

echo "=== 6. Actualisation des dépôts avec la nouvelle source Docker ==="
# Met à jour la liste des paquets en intégrant le dépôt Docker fraîchement configuré
apt-get update

echo "=== 7. Installation de Docker CLI, du moteur (Engine) et des plugins ==="
# docker-ce : le moteur Docker (démon dockerd)
# docker-ce-cli : l'outil en ligne de commande pour piloter Docker (la CLI demandée)
# containerd.io : le runtime de bas niveau qui gère le cycle de vie des conteneurs
# docker-buildx-plugin : outil moderne pour construire des images Docker
# docker-compose-plugin : permet d'utiliser 'docker compose' directement en CLI
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== 8. Activation et démarrage du service système Docker ==="
# Active le service pour qu'il démarre automatiquement au boot de la VM
systemctl enable docker
# Démarre le service Docker immédiatement
systemctl start docker

echo "=== 9. Vérification des versions installées ==="
# Affiche la version du client CLI et du serveur Docker pour confirmer la bonne installation
docker --version

echo "Installation du Job 01 terminée avec succès."