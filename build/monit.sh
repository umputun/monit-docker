#!/bin/sh

echo "restart monit"
pid=`cat /var/run/monit.pid`
kill -s HUP $pid

