#!/bin/bash

printenv | sed 's/^\(.*\)$/export \1/g' > /scripts/project_env.sh
cron && tail -f /var/log/cron.log