#!/bin/sh

set -e

until [ `ls -A /trojan-cert|wc -w` -ge 1 ]
do
  >&2 echo "ssl certs is empty - checking..."
  sleep 1
done

exec $@
