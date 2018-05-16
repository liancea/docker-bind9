#!/bin/bash
set -ue

if [[ "$EUID" != 0 ]]; then
    echo "Bitte als root ausfuehren!"
    exit 1
fi

wget -nv -O /etc/bind/db.root.new -4 -- "ftp://ftp.internic.net/domain/named.cache"
cd /etc/bind
mv db.root db.root.old
mv db.root.new db.root
rndc reload

