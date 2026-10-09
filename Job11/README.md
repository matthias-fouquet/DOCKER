# Job 11 — Portainer CE et Alternatives

## 1. Déploiement et Initialisation
Portainer CE est déployé via un conteneur officiel accédant au socket Docker hôte :
- **Ports exposés** : `9443` (HTTPS UI) et `8000` (Edge Agent)
- **Volume persistant** : `portainer_data` monté sur `/data`
- **Socket hôte** : `/var/run/docker.sock` pour administrer l'environnement local

Au premier lancement, la sécurisation exige un jeton d'initialisation (setup token) récupéré directement dans les journaux du conteneur via `docker logs portainer`.

---

## 2. Équivalences CLI vs Interface Portainer (Jobs 02 à 09)

| Job | Action CLI | Équivalent dans l'interface Portainer |
|---|---|---|
| **Job 02** | `docker run hello-world` | **Containers** > *Add container* (spécifier l'image `hello-world`) |
| **Job 03 / 04 / 08** | `docker build -t ... .` | **Images** > *Build a new image* (éditeur Web de Dockerfile intégré) |
| **Job 05** | Alias bash (`~/.bashrc`) | *Aucun équivalent direct* : les alias appartiennent à la configuration du shell Linux hôte. |
| **Job 06** | `docker volume create / inspect` | **Volumes** > *Add volume* / liste détaillée des points de montage |
| **Job 07 / 09** | `docker compose up -d` | **Stacks** > *Add stack* (éditeur Web pour coller directement le contenu du fichier Compose) |

---

## 3. Étude comparative des alternatives à Portainer

| Solution | Cas d'usage principal | Points forts | Limites |
|---|---|---|---|
| **Dockge** | Gestion de stacks Docker Compose | Interface très légère, édition en temps réel et réorganisation des fichiers YAML locaux. | Pas d'orchestration multi-nœuds ni de gestion fine des accès utilisateurs (RBAC). |
| **Lazydocker** | Administration en mode console (TUI) | Fonctionne directement dans le terminal (SSH), ultra-rapide et sans ressources consommées. | Aucune interface Web graphique partagée pour une équipe. |
| **Podman Desktop** | Remplacement de Docker Desktop | Compatible conteneurs sans privilèges root (rootless), intégration native Podman et Docker. | Nécessite un environnement graphique sur le poste client, non adapté à un serveur console pur. |
| **Rancher** | Orchestration multi-clusters Kubernetes | Plateforme d'entreprise complète pour gouverner des clusters K8s et déployer à grande échelle. | Très lourd à déployer, surdimensionné pour des conteneurs isolés ou de petits serveurs. |