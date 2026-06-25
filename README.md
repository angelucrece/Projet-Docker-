# Projet Docker - Initiation

## Description

Ce projet a pour objectif de découvrir Docker à travers la conteneurisation d'une application Node.js simple.

L'application affiche le message :

Bonjour Docker !

## Technologies utilisées

- Node.js
- Express
- Git / GitHub
- Docker (à venir)

## Prérequis

Avant de commencer, assurez-vous d'avoir installé :

- Node.js
- npm
- Git

## Récupération du projet

Cloner le dépôt :

```bash
git clone URL_DU_DEPOT
```

Entrer dans le dossier :

```bash
cd Projet-Docker-
```

## Installation des dépendances

Installer les dépendances du projet :

```bash
npm install
```

## Lancement de l'application

Démarrer le serveur :

```bash
npm start
```

Le serveur démarre sur :

http://localhost:3000

Vous devriez voir :

Bonjour Docker !

## Organisation de l'équipe

Chaque membre travaille dans sa propre branche.

Créer une branche :

```bash
git checkout -b nom-de-la-branche
```

Exemple :

```bash
git checkout -b dockerfile
```

Envoyer la branche sur GitHub :

```bash
git push -u origin nom-de-la-branche
```

## Règles de travail

- Ne jamais travailler directement sur la branche main.
- Faire des commits réguliers.
- Tester les modifications avant de les envoyer.
- Utiliser des messages de commit clairs.

Exemples :

```bash
git commit -m "Ajout du Dockerfile"
```

```bash
git commit -m "Mise à jour du README"
```

## Structure actuelle du projet

```text
docker-initiation/
│
├── index.js
├── package.json
├── package-lock.json
├── .gitignore
└── README.md
```

## État d'avancement

- [x] Création du projet Node.js
- [x] Installation d'Express
- [x] Mise en place de Git
- [ ] Dockerfile multi-stage
- [ ] Registry Docker
- [ ] Sécurité Docker
- [ ] Documentation finale

## Répartition des tâches

| Membre | Tâche |
|---------|---------|
| Membre 1 | Application Node.js |
| Membre 2 | Dockerfile multi-stage |
| Membre 3 | Registry Docker |
| Membre 4 | Sécurité et README |
