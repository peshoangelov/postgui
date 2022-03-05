#!/bin/bash
/opt/postgrest/postgrest /opt/postgrest/conf/db.conf &
cd /opt/PostGUI
screen -D -m "npm start"
while true; do sleep 1; don