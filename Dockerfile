FROM node:lts-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

FROM deps AS build
WORKDIR /app
COPY --chown=appuser:appgroup . .
RUN npm run build

FROM node:lts-alpine AS runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/next.config.js ./
COPY --from=build /app/public ./public
COPY --chown=appuser:appgroup --from=build /app/package.json ./package.json
RUN apk add --no-cache tini
USER appuser
EXPOSE 3000
ENV NODE_ENV=production
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1
CMD ["tini", "--", "npm", "start"]