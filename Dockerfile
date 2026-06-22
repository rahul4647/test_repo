# Stage 1: deps
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS deps
RUN npm install

# Stage 2: build (not needed for this stack)
# No build stage required

# Stage 3: runtime
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
WORKDIR /app
COPY --chown=appuser:appgroup package*.json ./
RUN npm install --only=production
COPY --chown=appuser:appgroup . .
ENV NODE_ENV=production
HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD curl --fail http://localhost:3000/health || exit 1
EXPOSE 3000
CMD ["tini", "--", "npm", "run", "start"]