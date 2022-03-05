#!/bin/bash
/opt/postgrest/postgrest /opt/postgrest/conf/db.conf &
cd /opt/PostGUI
npm start
