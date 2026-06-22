# Stage 1: deps
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS deps
# Install dependencies
RUN npm install --only=production

# Stage 2: build (not needed for this stack)
# No build stage required for this application

# Stage 3: runtime
FROM node:20-alpine@sha256:2f34f3253e50e1a2a0fd5a82e26bef4e21e9b0eae7812835e58a8fca1cdc392c AS runtime
# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# Switch to non-root user
USER appuser
# Set environment variables
ENV NODE_ENV=production
# Copy dependencies
COPY --chown=appuser:appgroup node_modules/ /app/node_modules/
# Copy application code
COPY --chown=appuser:appuser . /app/
# Set working directory
WORKDIR /app
# Expose port
EXPOSE 3000
# Health check
HEALTHCHECK --interval=30s --timeout=5s --retries=3 --start-period=30s CMD curl --fail http://localhost:3000/health || exit 1
# Run command
CMD ["node", "next", "start"]