#!/bin/bash

log() {
    SEVERITY=$1
    TEXT=$2
    printf "$1\t:$2\n"
    if [ $SEVERITY == "ERROR" ]; then
        exit 1
    fi 
}

#create directories
for dir in postgrest PostGUI; do
   mkdir -p $dir
done
#install binaries
if [ ! -x /usr/bin/wget ]; then
   yum install -y wget
fi
if [ ! -x /usr/bin/git ]; then
   yum install -y git
fi
if [ $(systemctl status docker &>/dev/null)$? -ne 0 ]; then
   systemctl start docker
   if [ $? -ne 0 ]; then
      log "ERROR" "Could not start docker"
   else
      log "INFO" "started docker service"
   fi
fi
if [ ! -x /usr/bin/docker ]; then
   yum install -y epel-release
   yum install -y docker
   systemctl restart docker
fi
 
#fetch required binaries
wget -q https://github.com/PostgREST/postgrest/releases/download/v0.4.4.0/postgrest-v0.4.4.0-centos7.tar.xz -O - | tar Jxf - -C postgrest/
if [ $? -ne 0 ]; then
    log "ERROR" "Cannot download postgrest"
else
    log "INFO" "Downloaded postgres"
fi

#fetch app
git clone https://github.com/priyank-purohit/PostGUI.git &>/dev/null
if [ $? -ne 0 ]; then
    log "ERROR" "Cannot clone app"
else
    log "INFO" "App cloned from git"
fi

#Clean git before packaging
rm -rf ./PostGUI/.git

docker build -t postgui:0.2 .
