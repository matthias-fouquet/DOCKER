#!/bin/bash
# ==============================================================================
# Job 10 : Automatisation de l'installation officielle de Docker sur Debian
# Auteur : Matthias FOUQUET
# Objectif : Installer Docker Engine, la CLI et le plugin Compose de manière
#            idempotente, sécurisée et reproductible.
# ==============================================================================

# Arrêter l'exécution immédiatement si une commande échoue (-e),
# si une variable est non définie (-u) ou si un pipe plante (-o pipefail)
set -euo pipefail

echo "=== 1. Vérification des prérequis d'exécution ==="
# Le script doit tourner sous le compte root (ou avec sudo)
[ "$EUID" -eq 0 ] || { echo "Erreur : ce script doit être exécuté avec sudo ou en root."; exit 1; }

# Charge les variables d'environnement décrivant la distribution Linux
. /etc/os-release

# Bloque l'exécution si la machine n'est pas une distribution Debian
[ "$ID" = "debian" ] || { echo "Erreur : ce script est exclusivement conçu pour Debian."; exit 1; }

echo "=== 2. Installation des dépendances de base ==="
# ca-certificates : indispensable pour valider les connexions HTTPS
# curl : utilitaire pour requêter les fichiers distants (clé de signature GPG)
apt-get update
apt-get install -y ca-certificates curl

echo "=== 3. Téléchargement de la clé de signature GPG officielle ==="
# Crée un dossier sécurisé pour stocker les clés de validation d'APT
install -m 0755 -d /etc/apt/keyrings

# Télécharge la clé publique officielle Docker et la sauvegarde au format asc
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "=== 4. Configuration du dépôt APT officiel de Docker ==="
# Injecte la ligne de dépôt adaptée à la version courante de Debian (ex: trixie, bookworm)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $VERSION_CODENAME stable" \
  > /etc/apt/sources.list.d/docker.list

echo "=== 5. Installation des paquets officiels Docker ==="
# Actualise la base de données APT pour prendre en compte le nouveau dépôt
apt-get update

# Installe le démon (docker-ce), la CLI (docker-ce-cli), le runtime et le plugin Compose
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "=== 6. Gestion des droits d'accès non-root ==="
# Ajoute l'utilisateur qui a invoqué sudo (ou root par défaut) au groupe local 'docker'
# Cela permet d'exécuter des commandes docker sans retaper 'sudo' à chaque fois
usermod -aG docker "${SUDO_USER:-root}"

echo "=== 7. Test de validation du bon fonctionnement ==="
# Lance le conteneur hello-world pour prouver que le démon répond et fonctionne
docker run --rm hello-world

echo "=== Installation automatisée réussie avec succès. ==="