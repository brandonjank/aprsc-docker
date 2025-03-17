#!/bin/bash
set -e
envsubst < /etc/aprsc/aprsc.conf.template > /opt/aprsc/aprsc.conf
exec "$@"
