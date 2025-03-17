#!/bin/bash
set -e
envsubst < /opt/aprsc/aprsc.conf.template > /opt/aprsc/aprsc.conf
exec "$@"
