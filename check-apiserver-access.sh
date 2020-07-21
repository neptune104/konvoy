#!/bin/bash
APISERVER=$(kubectl config view | grep server | cut -f 2- -d ":" | tr -d " ") 
# Retrieve 'default' account's TOKEN in 'default' namespace 
TOKEN="$(kubectl get secret -n kube-system $(kubectl get secrets -n kube-system | grep aihub | cut -f1 -d ' ') -o jsonpath='{$.data.token}' | base64 --decode)"
echo $TOKEN
curl -D - --insecure --header "Authorization: Bearer $TOKEN" $APISERVER/api/v1/namespaces/default/services
