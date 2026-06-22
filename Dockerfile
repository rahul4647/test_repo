FROM node:lts-alpine as deps
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production

FROM deps as build
WORKDIR /app
COPY --chown=appuser:appgroup . .
RUN npm run build

FROM node:lts-alpine as runtime
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/next.config.js ./
COPY --chown=appuser:appgroup --from=build /app/public ./public
ENV NODE_ENV=production
RUN apk add --no-cache tini
USER appuser
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "start"]