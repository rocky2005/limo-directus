FROM directus/directus:11.0.2

WORKDIR /directus

COPY --chown=node:node snapshots/ ./snapshots/
COPY --chown=node:node bootstrap.sh ./bootstrap.sh

EXPOSE 8055

CMD ["sh", "bootstrap.sh"]
