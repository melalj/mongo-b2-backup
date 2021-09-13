FROM mongo:latest

WORKDIR /scripts

COPY backup.sh .
COPY restore.sh .
COPY entrypoint.sh .
RUN chmod +x backup.sh
RUN chmod +x restore.sh
RUN chmod +x entrypoint.sh

RUN apt update && apt install python3 curl python3-pip cron -y
RUN pip3 install --upgrade b2

# Setup cron job
RUN touch /var/log/cron.log
RUN (crontab -l ; echo "0 12 * * * . $HOME/.profile; . /scripts/project_env.sh; /bin/bash /scripts/backup.sh >> /var/log/cron.log 2>&1") | crontab

# Run the command on container startup
ENTRYPOINT bash ./entrypoint.sh
