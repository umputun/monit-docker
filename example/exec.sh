#!/bin/sh
cp -f /tmp/example-monit.conf /etc/monit/conf.d/ #inject monit's config for this container
echo "example is running. will be dead in 2 minutes ..."
sleep 120

