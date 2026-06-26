# Projet Docker – Initiation à la conteneurisation d’une application Node.js

## 1. Présentation du projet

Ce projet a été réalisé dans le cadre d’une initiation à **Docker** dans le module de **CI/CD**.
L’objectif est de découvrir les principes de base de la conteneurisation en partant d’une application **Node.js** simple, puis en créant une **image Docker** à l’aide d’un **Dockerfile multi-stage**.

L’application développée affiche un message simple dans le navigateur :

**Bonjour Docker !**

Ce projet constitue une première étape vers la compréhension de Docker et de son utilisation dans une démarche plus large d’intégration et de déploiement continus.

---

## 2. Objectifs du mini-projet

Les objectifs de ce travail sont les suivants :

* comprendre le rôle de Docker dans l’exécution d’une application ;
* conteneuriser une application Node.js simple ;
* créer une image Docker à l’aide d’un **Dockerfile multi-stage** ;
* lancer un conteneur à partir de cette image ;
* vérifier le bon fonctionnement de l’application dans un environnement isolé ;
* préparer la suite du travail autour des **registries Docker** et des **bonnes pratiques de sécurité**.

---

## 3. Qu’est-ce que Docker ?

Docker est une plateforme de **conteneurisation** qui permet d’exécuter une application dans un environnement isolé, portable et reproductible.

Concrètement, Docker permet de regrouper :

* le code de l’application ;
* ses dépendances ;
* son environnement d’exécution ;
* sa commande de démarrage.

L’objectif est de garantir qu’une application fonctionne de la même manière sur différentes machines, qu’il s’agisse du poste du développeur, d’un serveur de test ou d’un environnement de production.

---

## 4. Notions essentielles

### 4.1 Image Docker

Une **image Docker** est un modèle contenant tout le nécessaire pour exécuter une application : base système, dépendances, code source et instructions de lancement.

### 4.2 Conteneur

Un **conteneur** est une instance en cours d’exécution créée à partir d’une image Docker.

### 4.3 Dockerfile

Le **Dockerfile** est un fichier de configuration qui décrit, étape par étape, comment construire une image Docker.

Dans ce projet, il permet notamment de :

* définir l’image de base ;
* copier les fichiers du projet ;
* installer les dépendances ;
* exposer le port de l’application ;
* définir la commande de démarrage.

---

## 5. Technologies utilisées

* **Node.js**
* **Express**
* **Docker**
* **Git / GitHub**

---

## 6. Structure du projet

La structure actuelle du projet est la suivante :

```text
Projet-Docker-/
│
├── app/
│   └── index.js
├── package.json
├── package-lock.json
├── Dockerfile
├── .dockerignore
├── .gitignore
└── README.md
```

---

## 7. Fonctionnement de l’application

L’application est une petite application **Node.js / Express** qui démarre un serveur local sur le port **3000** et affiche le message :

**Bonjour Docker !**

Le fichier principal de l’application est :

```bash
app/index.js
```

Le script de démarrage défini dans `package.json` est :

```json
"start": "node app/index.js"
```

---

## 8. Dockerfile multi-stage mis en place

Dans ce projet, nous avons utilisé un **Dockerfile multi-stage** afin de séparer la phase de préparation de l’application de l’image finale d’exécution.

### Dockerfile utilisé

```dockerfile
# Étape 1 : installation des dépendances
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY app ./app

# Étape 2 : image finale
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app ./app

EXPOSE 3000

CMD ["npm", "start"]
```

---

## 9. Explication du Dockerfile

### Étape 1 : préparation de l’application

La première étape, nommée `builder`, permet de préparer l’application :

* `FROM node:20-alpine AS builder` : utilisation d’une image Node.js légère comme base de travail ;
* `WORKDIR /app` : définition du répertoire de travail dans le conteneur ;
* `COPY package*.json ./` : copie des fichiers de dépendances ;
* `RUN npm install` : installation des dépendances du projet ;
* `COPY app ./app` : copie du code source de l’application.

### Étape 2 : construction de l’image finale

La seconde étape sert à construire l’image finale qui sera utilisée pour lancer le conteneur :

* `FROM node:20-alpine` : nouvelle image de base pour l’exécution ;
* `WORKDIR /app` : définition du répertoire de travail ;
* `COPY --from=builder ...` : récupération des fichiers nécessaires depuis l’étape précédente ;
* `EXPOSE 3000` : indication du port utilisé par l’application ;
* `CMD ["npm", "start"]` : commande exécutée au démarrage du conteneur.

L’intérêt du multi-stage est de structurer la construction de l’image et de séparer la phase de préparation de la phase d’exécution.

---

## 10. Fichier `.dockerignore`

Le fichier `.dockerignore` permet d’exclure certains fichiers inutiles du contexte de build Docker.
Dans ce projet, il contient :

```gitignore
node_modules
npm-debug.log
.git
.gitignore
README.md
```

Cela permet d’éviter d’envoyer au build des fichiers ou dossiers non nécessaires à la construction de l’image.

---

## 11. Prérequis

Avant d’exécuter le projet, il faut disposer des outils suivants :

* **Node.js**
* **npm**
* **Docker**
* **Git**

---

## 12. Récupération du projet

Cloner le dépôt :

```bash
git clone URL_DU_DEPOT
```

Se placer dans le dossier du projet :

```bash
cd Projet-Docker-
```

---

## 13. Exécution de l’application sans Docker

Installer les dépendances :

```bash
npm install
```

Lancer l’application :

```bash
npm start
```

Ouvrir ensuite le navigateur à l’adresse suivante :

```bash
http://localhost:3000
```

---

## 14. Construction de l’image Docker

Pour construire l’image Docker à partir du Dockerfile, exécuter la commande suivante :

```bash
docker build -t projet-docker .
```

Cette commande permet de créer une image Docker nommée **projet-docker**.

---

## 15. Lancement du conteneur

Une fois l’image construite, le conteneur peut être lancé avec la commande suivante :

```bash
docker run -p 3000:3000 projet-docker
```

Cette commande :

* lance un conteneur à partir de l’image `projet-docker` ;
* associe le port `3000` du conteneur au port `3000` de la machine hôte.

L’application devient alors accessible depuis le navigateur à l’adresse :

```bash
http://localhost:3000
```

Si le message **Bonjour Docker !** s’affiche, cela signifie que :

* l’image a été correctement construite ;
* le conteneur démarre correctement ;
* l’application fonctionne dans Docker.


## . Conclusion

Cette première étape du projet nous a permis de comprendre le fonctionnement général de Docker à travers un cas simple de conteneurisation d’une application Node.js.

Nous avons pu :

* créer une image Docker à partir d’un Dockerfile ;
* mettre en place un Dockerfile multi-stage ;
* lancer un conteneur fonctionnel ;
* vérifier l’exécution de l’application dans un environnement isolé.

La suite du travail portera sur la **publication de l’image dans une registry Docker** ainsi que sur l’étude de quelques **bonnes pratiques de sécurité** liées à la conteneurisation.

## 16. Registry Docker (Docker Hub)

### 16.1 Introduction

Une **registry Docker** est un service qui permet de stocker, gérer et partager des images Docker. Elle joue un rôle similaire à celui de GitHub pour le code source : au lieu de stocker des fichiers de projet, elle stocke des images Docker prêtes à être exécutées.

Dans ce projet, nous avons utilisé **Docker Hub** comme registry afin de publier l'image de notre application Node.js. Cette publication permet à n'importe quel développeur autorisé de télécharger l'image et d'exécuter l'application sans avoir à reconstruire le projet.

---

### 16.2 Pourquoi utiliser une registry ?

L'utilisation d'une registry présente plusieurs avantages :

* Centraliser les images Docker dans un espace sécurisé.
* Faciliter le partage de l'application entre les membres de l'équipe.
* Éviter à chaque développeur de reconstruire l'image sur sa machine.
* Simplifier le déploiement de l'application sur différents environnements (développement, test ou production).
* Gérer différentes versions d'une même image grâce aux tags.

---

### 16.3 Registry utilisée

Pour ce projet, la registry choisie est **Docker Hub**, qui est la registry publique officielle de Docker.

Notre image est publiée dans le dépôt Docker Hub de l'équipe afin qu'elle puisse être téléchargée et utilisée sur une autre machine.

---

### 16.4 Processus de publication de l'image

Après la création du Dockerfile et la construction de l'image Docker, plusieurs étapes ont été réalisées afin de publier l'image sur Docker Hub.

#### Étape 1 : Connexion à Docker Hub

Avant toute publication, il est nécessaire de s'authentifier auprès de Docker Hub.

```bash
docker login
```

Cette commande permet d'associer le terminal au compte Docker Hub utilisé pour publier l'image.

---

#### Étape 2 : Attribution d'un tag

Une image construite localement doit être associée au dépôt Docker Hub grâce à un **tag**.

```bash
docker tag projet-docker angelucrece/projet_docker:1.0
```

Cette commande indique que l'image locale `projet-docker` sera publiée dans le dépôt `projet_docker` appartenant à l'utilisateur `angelucrece`.

Le tag **1.0** représente la première version officielle de l'image.

---

#### Étape 3 : Publication de l'image

Une fois l'image correctement taguée, elle est envoyée vers Docker Hub.

```bash
docker push angelucrece/projet_docker:1.0
```

Docker transfère automatiquement toutes les couches de l'image vers la registry.

Une fois cette opération terminée, l'image devient disponible sur Docker Hub.

---

#### Étape 4 : Téléchargement de l'image

Depuis une autre machine, il suffit d'exécuter la commande suivante :

```bash
docker pull angelucrece/projet_docker:1.0
```

L'image est alors téléchargée localement et peut être exécutée immédiatement avec Docker.

---

### 16.5 Schéma de fonctionnement

Le processus complet peut être résumé de la manière suivante :

```text
Application Node.js
        │
        ▼
Construction de l'image Docker
        │
        ▼
Image Docker locale
        │
        ▼
Tag de l'image
        │
        ▼
Publication sur Docker Hub
        │
        ▼
Téléchargement depuis une autre machine
        │
        ▼
Exécution du conteneur
```

---

### 16.6 Résultat obtenu

À l'issue de cette étape, l'image Docker de notre application a été publiée avec succès sur Docker Hub.

L'application peut désormais être récupérée depuis n'importe quelle machine disposant de Docker, simplement à l'aide de la commande `docker pull`, sans avoir besoin de recompiler le projet.

Cette approche facilite le travail collaboratif, le partage de l'application et son déploiement dans différents environnements.

---

## 17. État d’avancement du projet

* [x] Création du projet Node.js
* [x] Installation d’Express
* [x] Initialisation du dépôt Git
* [x] Création du Dockerfile multi-stage
* [x] Création du fichier `.dockerignore`
* [x] Construction de l’image Docker
* [x] Exécution du conteneur Docker
* [x] Registry Docker
* [ ] Sécurité Docker
* [ ] Finalisation de la documentation

---

## 18. Répartition des tâches

| Membre   | Tâche                                  |
| -------- | -------------------------------------- |
| Membre 1 | Mise en place de l’application Node.js |
| Membre 2 | Création du Dockerfile multi-stage     |
| Membre 3 | Partie registry Docker                 |
| Membre 4 | Partie sécurité et documentation       |

---
