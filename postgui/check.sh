#!/bin/bash
counter=5

get_pod_status() {
    [ -z $1 ] && exit 100
    POD_STATUS=$(kubectl get pods | awk '/'$1'/{print $3}')
    printf $POD_STATUS
}

pod_status=$(get_pod_status postgui)

if [ ${pod_status} == "Running" ]; then
   while [ $counter -gt 0 ]; do
       sleep 5s
       if [ $(get_pod_status postgui) == "Running" ]; then
          ((counter--))
       else
          printf "Container unstable, exiting\n"
          exit 2
       fi
   done
   printf "Container running\n"
   exit 0
else
   printf "Container is not running\n"
   exit 1
fi

   
