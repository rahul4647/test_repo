# Stage 1: deps
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS deps
# Install dependencies
WORKDIR /app
COPY package*.json ./
RUN npm install --production

# Stage 2: build (not needed for this project)
# FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS build
# WORKDIR /app
# COPY . .
# RUN npm run build

# Stage 3: runtime
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --chown=appuser:appgroup node_modules/ node_modules/
COPY --chown=appuser:appgroup . .
USER appuser
ENV NODE_ENV=production
EXPOSE 3000
HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD curl --fail http://localhost:3000/health || exit 1
CMD ["tini", "--", "npm", "run", "start"]