FROM mongo:latest

WORKDIR /scripts

COPY backup.sh .
COPY restore.sh .
RUN chmod +x backup.sh
RUN chmod +x restore.sh

RUN apt update && apt install python3 curl python3-pip cron -y
RUN pip3 install --upgrade b2


ENV RESTORE_ARCHIVE_NAME ""
ENV RESTORE_EXTRA_PARAMS ""
ENV BACKUP_EXTRA_PARAMS ""
ENV AUTH_DB_NAME ""
ENV DB_NAME ""
ENV MONGODB_URI ""
ENV B2_BUCKET ""
ENV B2_ACCOUNT_ID ""
ENV B2_ACCESS_KEY ""

# Setup cron job
RUN touch /var/log/cron.log
RUN printenv | sed 's/^\(.*\)$/export \1/g' > /scripts/project_env.sh
RUN (crontab -l ; echo "0 12 * * * . $HOME/.profile; . /scripts/project_env.sh; /bin/bash /scripts/backup.sh >> /var/log/cron.log 2>&1") | crontab

# Run the command on container startup
ENTRYPOINT cron && tail -f /var/log/cron.log
