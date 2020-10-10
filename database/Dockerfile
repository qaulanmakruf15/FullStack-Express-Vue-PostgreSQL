FROM postgres

COPY restore.sh /docker-entrypoint-initdb.d/restore.sh
COPY POS.sql /usr/sql/POS.sql

ENV PGDATA=/data
