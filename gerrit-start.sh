#!/usr/bin/env sh
set -e
echo "Running haveged for additional entropy for Cloud Servers, this should help gerrit start faster".
haveged -w 1024 &
echo "Starting Gerrit..."
exec su-exec ${GERRIT_USER} ${GERRIT_SITE}/bin/gerrit.sh ${GERRIT_START_ACTION:-daemon}
