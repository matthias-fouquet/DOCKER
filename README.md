# DOCKER — La Plateforme

Projet pratique d'administration et de conteneurisation basé sur Docker sous Debian. Ce dépôt contient l'ensemble des scripts Bash, Dockerfiles, configurations Compose et documentations couvrant les 11 Jobs du cursus.

---

## Sommaire

- [Environnement technique](#environnement-technique)
- [Arborescence du dépôt](#arborescence-du-dépôt)
- [Documentation des Jobs](#documentation-des-jobs)
  - [Bloc 1 : Prise en main et CLI](#bloc-1--prise-en-main-et-cli)
  - [Bloc 2 : Dockerfile et volumes](#bloc-2--dockerfile-et-volumes)
  - [Bloc 3 : Multi-conteneurs (Compose & Registry)](#bloc-3--multi-conteneurs-compose--registry)
  - [Bloc 4 : Production et supervision](#bloc-4--production-et-supervision)
- [Rendu et évaluation](#rendu-et-évaluation)

---

## Environnement technique

- **Hôte :** macOS (Apple Silicon ARM64)
- **Machine virtuelle :** Debian GNU/Linux en mode console (sans interface graphique)
- **Dimensionnement VM :** 1 vCPU, 1 Go RAM, 8 Go disque
- **Moteur de conteneurisation :** Docker Engine CE + Docker CLI + Docker Compose Plugin (v2)

---

## Arborescence du dépôt

```text
.
├── README.md
├── Job01.md
├── Job02.md
├── job03/
│   ├── Dockerfile
│   └── run.sh
├── job04/
│   ├── Dockerfile
│   └── run.sh
├── job05/
│   ├── aliases.sh
│   └── install_aliases.sh
├── job06/
│   └── test_volumes.sh
├── job07/
│   ├── docker-compose.yml
│   ├── index.html
│   └── run.sh
├── job08/
│   ├── Dockerfile
│   ├── index.html
│   └── run.sh
├── job09/
│   ├── docker-compose.yml
│   └── run.sh
├── job10/
│   ├── clean-docker.sh
│   └── install-docker.sh
└── job11/
    ├── deploy_portainer.sh
    └── README.md
