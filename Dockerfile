FROM postgres:14

# Install PostGIS, pg_cron, pg_repack, pg_partman, hypoPG

RUN apt update && \
    apt install -y --no-install-recommends apt-transport-https lsb-release wget curl gnupg ca-certificates && \
    /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y && \
    apt install --no-install-recommends -y postgresql-14-postgis-3 postgresql-14-postgis-3-scripts gnupg postgresql-common \
    postgresql-14-cron postgresql-14-repack postgresql-14-partman \
    postgresql-14-hypopg && \
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install TimescaleDB
RUN wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/timescale/timescaledb/debian/ bullseye main" | tee /etc/apt/sources.list.d/timescaledb.list
RUN apt update && \
    /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y && \
    apt update && \
    apt install timescaledb-2-postgresql-14 -y && \
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
