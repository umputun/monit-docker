#!/bin/bash

echo "monit host = $MHOST"
cp -f /srv/monit/conf.d/* /etc/monit/conf.d/
sed -i "s/MHOST/$MHOST/g" /etc/monit/conf.d/common.conf
sed -i "s/MAIL_SERVER/$MAIL_SERVER/g" /etc/monit/conf.d/common.conf
sed -i "s/ALERT_EMAIL/$ALERT_EMAIL/g" /etc/monit/conf.d/common.conf
sed -i "s/MONIT_USER/$MONIT_USER/g" /etc/monit/conf.d/common.conf
sed -i "s/MONIT_PASS/$MONIT_PASS/g" /etc/monit/conf.d/common.conf

ls /hostsrv/ | grep -v moint | xargs -I {} ln -s /hostsrv/{} /srv/{}

monit -I &
sleep 3
tail -F /var/log/monit &

echo "start watcher for /etc/monit/conf.d/"
while inotifywait -r -e modify /etc/monit/conf.d/ ; do /srv/monit/monit.sh; done
