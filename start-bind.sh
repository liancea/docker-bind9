#!/bin/bash
set -ue

# start cron daemon
/usr/sbin/cron

# populate /etc/bind volume if empty
if [[ -z "$(ls -A /etc/bind)" ]]; then
    cp -Ta /var/bind9-distconfig/etc_bind /etc/bind
fi

# populate /var/lib/bind volume if empty
if [[ -z "$(ls -A /var/lib/bind)" ]]; then
    cp -Ta /var/bind9-distconfig/var_lib_bind /var/lib/bind
fi

# start bind
exec /usr/sbin/named -g -u bind
