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