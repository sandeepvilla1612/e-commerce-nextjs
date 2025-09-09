# Stage 1: Build
FROM node:18-bullseye AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Run
FROM node:18-bullseye-slim
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app ./
RUN npm ci --omit=dev

EXPOSE 3000
CMD ["npm", "run", "start"]
