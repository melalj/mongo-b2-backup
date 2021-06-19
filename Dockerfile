FROM mongo:latest

WORKDIR /scripts

COPY backup.sh .
COPY restore.sh .
RUN chmod +x backup.sh
RUN chmod +x restore.sh

RUN apt update && apt install python3 curl python3-pip -y
RUN pip install --upgrade b2


ENV RESTORE_ARCHIVE_NAME ""
ENV RESTORE_EXTRA_PARAMS ""
ENV BACKUP_EXTRA_PARAMS ""
ENV AUTH_DB_NAME ""
ENV DB_NAME ""
ENV MONGODB_URI ""
ENV B2_BUCKET ""
ENV B2_ACCOUNT_ID ""
ENV B2_ACCESS_KEY ""

ENTRYPOINT ["bash", "/scripts/backup.sh"]