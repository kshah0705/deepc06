#! /bin/bash


kubectl get deployment $1 > /dev/null 2>&1;
if [ $? -ne 0 ]; then
   echo 'deployment does not exist | creating it'
   cat /home/dilip/autodeploy.yaml | sed 's/\$name/'"$1"'/' > /home/dilip/$1.yaml
   kubectl create -f /home/dilip/$1.yaml
   sleep 7
fi

kubectl exec -it $(kubectl get pods -l app=$1 | awk '/'"$1"'*/ {print $1; exit;}') -- python /home/container/userConfig/$2
