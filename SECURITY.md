\# Sécurité Docker



\## Bonnes pratiques appliquées



\### 1. Utilisation d'une image officielle



Utiliser une image officielle Node.js afin de limiter les risques liés aux images non vérifiées.



\### 2. Exécution avec un utilisateur non root



Ne jamais exécuter l'application avec l'utilisateur root dans le conteneur.



Exemple :



```dockerfile

USER node

