#!/usr/bin/env bash

### ENVs
echo "Getting parameters"
while getopts p:s:r:n: flag
do
    # shellcheck disable=SC2220
    case "${flag}" in
        p) PROJECT=${OPTARG};;
        s) STORAGE_CLS=${OPTARG};;
        r) DOCKER_REPO=${OPTARG};;
        n) NODE_PORT=${OPTARG};;
    esac
done


if [ -z "$PROJECT" ]; then
    echo "ERROR || Parameter -s : PROJECT name is missing"
    exit
fi

if [ -z "$STORAGE_CLS" ]; then
    echo "ERROR || Parameter -s : STORAGE_CLS name is missing"
    exit
fi

if [ -z "$NODE_PORT" ]; then
    echo "Warning || Parameter -r : DOCKER_REPO name is empty"
    exit
fi

if [ -z "$DOCKER_REPO" ]; then
    echo "Warning || Parameter -r : DOCKER_REPO name is empty"
fi

oc delete -f config.yaml
oc process -f stateful-template.yaml -p STORAGE_CLS=$STORAGE_CLS -p DOCKER_REPO=$DOCKER_REPO | oc delete -f -
oc process -f service-template.yaml -p NODE_PORT=$NODE_PORT | \
    jq ".items[0].spec.ports[0].nodePort = ${NODE_PORT}" | \
    oc delete -f -
