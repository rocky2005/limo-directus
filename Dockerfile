FROM directus/directus:11.0.2

USER root
RUN corepack enable && corepack prepare pnpm@latest --activate
USER node

WORKDIR /directus

COPY --chown=node:node snapshots/ ./snapshots/
COPY --chown=node:node bootstrap.sh ./bootstrap.sh

EXPOSE 8055

CMD ["sh", "bootstrap.sh"]
