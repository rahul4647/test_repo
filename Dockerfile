FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder --chown=appuser:appgroup /app/.next ./.next
COPY --chown=appuser:appgroup package.json ./
COPY --chown=appuser:appgroup public ./public
USER appuser
ENV NODE_ENV=production
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "start"]
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/health || exit 1