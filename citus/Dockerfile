
# Dockerfile
FROM ghcr.io/hydradatabase/hydra:16-3cdf8367ae8717e67c60daf4e5eafd7134de589a

# # Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
    && curl -s https://install.citusdata.com/community/deb.sh | bash \
    && apt-get install -y postgresql-16-citus-12.1 \
                          postgresql-16-hll=2.18.citus-1 \
                          postgresql-16-topn=2.6.0.citus-1

# Copy the modified postgresql.conf file
#COPY files/postgres/postgresql.conf /etc/postgresql/postgresql.conf

# # Start the PostgreSQL server with the custom configuration
# CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]

# # add citus to default PostgreSQL config
# RUN echo "shared_preload_libraries='citus'" >> /usr/share/postgresql/postgresql.conf.sample

# add scripts to run after initdb
# COPY 001-create-citus-extension.sql /docker-entrypoint-initdb.d/

# add health check script
COPY pg_healthcheck wait-for-manager.sh /
RUN chmod +x /wait-for-manager.sh

# entry point unsets PGPASSWORD, but we need it to connect to workers
# https://github.com/docker-library/postgres/blob/33bccfcaddd0679f55ee1028c012d26cd196537d/12/docker-entrypoint.sh#L303
RUN sed "/unset PGPASSWORD/d" -i /usr/local/bin/docker-entrypoint.sh

HEALTHCHECK --interval=4s --start-period=6s CMD ./pg_healthcheck