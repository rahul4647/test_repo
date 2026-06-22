FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production

FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --chown=appuser:appgroup --from=build /app/.next ./.next
COPY --chown=appuser:appgroup package*.json ./
RUN npm install --only=production && npm cache clean --force;
USER appuser
ENV NODE_ENV=production
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD [ "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3000/health" ] || exit 1
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "start"]