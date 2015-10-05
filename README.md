# monit-docker
Dockerized monit

This  container designed to run as a single, common monit on a box to provide monitoring services for all other containers on the same server. Each application container delivers its own monit's config and injects it to monit volume.

Edit docker-compose.yml with your parmas (email server, alert email, monit user and passwd) and then run it with `MHOST=$(hostname -s) docker-compose up -d`

see example of application container in example/
