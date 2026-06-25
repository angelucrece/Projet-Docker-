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

---

## 16. État d’avancement du projet

* [x] Création du projet Node.js
* [x] Installation d’Express
* [x] Initialisation du dépôt Git
* [x] Création du Dockerfile multi-stage
* [x] Création du fichier `.dockerignore`
* [x] Construction de l’image Docker
* [x] Exécution du conteneur Docker
* [ ] Registry Docker
* [ ] Sécurité Docker
* [ ] Finalisation de la documentation

---

## 17. Répartition des tâches

| Membre   | Tâche                                  |
| -------- | -------------------------------------- |
| Membre 1 | Mise en place de l’application Node.js |
| Membre 2 | Création du Dockerfile multi-stage     |
| Membre 3 | Partie registry Docker                 |
| Membre 4 | Partie sécurité et documentation       |

---

## 18. Conclusion

Cette première étape du projet nous a permis de comprendre le fonctionnement général de Docker à travers un cas simple de conteneurisation d’une application Node.js.

Nous avons pu :

* créer une image Docker à partir d’un Dockerfile ;
* mettre en place un Dockerfile multi-stage ;
* lancer un conteneur fonctionnel ;
* vérifier l’exécution de l’application dans un environnement isolé.

La suite du travail portera sur la **publication de l’image dans une registry Docker** ainsi que sur l’étude de quelques **bonnes pratiques de sécurité** liées à la conteneurisation.
