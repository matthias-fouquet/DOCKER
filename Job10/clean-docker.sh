#!/bin/bash
# ==============================================================================
# Job 10 : Désinstallation et purge complète de Docker
# Auteur : Matthias FOUQUET
# Objectif : Supprimer tous les conteneurs, images, volumes, réseaux, paquets et
#            fichiers résiduels pour restaurer le système Debian à blanc.
# ==============================================================================

# -u : traite les variables non définies comme des erreurs
# On n'utilise PAS set -e pour ne pas stopper si aucun conteneur n'est trouvé
set -u

echo "=== 1. Contrôle des privilèges administrateur ==="
# Vérifie que le script est bien lancé par le superutilisateur root (EUID 0)
if [ "$EUID" -ne 0 ]; then
  echo "Erreur : ce script de purge doit impérativement être exécuté en tant que root."
  exit 1
fi

echo "=== 2. Arrêt et suppression forcée de TOUS les conteneurs ==="
# docker ps -aq : liste tous les identifiants de conteneurs (actifs et arrêtés)
# xargs -r : n'exécute la commande suivante que si la liste n'est pas vide
# docker rm -f : force l'arrêt immédiat et la suppression de chaque conteneur
docker ps -aq | xargs -r docker rm -f

echo "=== 3. Suppression de TOUTES les images Docker locales ==="
# docker images -aq : liste les identifiants de toutes les images en cache local
# docker rmi -f : force la suppression de toutes les images
docker images -aq | xargs -r docker rmi -f

echo "=== 4. Suppression de TOUS les volumes Docker persistants ==="
# docker volume ls -q : liste les noms de tous les volumes gérés par Docker
# docker volume rm -f : purge définitivement les volumes et leurs données stockées
docker volume ls -q | xargs -r docker volume rm -f

echo "=== 5. Purge de tous les réseaux personnalisés ==="
# Supprime tous les réseaux de bridge personnalisés créés par Compose ou en CLI
docker network prune -f

echo "=== 6. Arrêt et désactivation des services système Docker ==="
# disable --now : coupe immédiatement les démons et empêche leur redémarrage au boot
systemctl disable --now docker docker.socket containerd 2>/dev/null || true

echo "=== 7. Purge complète des paquets logiciels APT ==="
# purge : retire les paquets ET tous leurs fichiers de configuration système globaux
apt-get purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin

# autoremove --purge : désinstalle toutes les dépendances orphelines devenues inutiles
apt-get autoremove -y --purge

echo "=== 8. Suppression des répertoires de données résiduels ==="
# Élimine les répertoires physiques sur le disque dur (/var/lib/docker contient les couches de stockage)
rm -rf /var/lib/docker
rm -rf /etc/docker
rm -rf /var/lib/containerd

echo "=== 9. Suppression du dépôt officiel APT de Docker ==="
# Retire le fichier source APT créé lors du Job 01 pour ne laisser aucune trace
rm -f /etc/apt/sources.list.d/docker.list

echo "=== Système Debian nettoyé avec succès. Docker est entièrement éradiqué. ==="