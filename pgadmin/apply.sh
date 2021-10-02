#!/usr/bin/env bash

### ENVs
echo "Getting parameters"
while getopts p:s:r:h: flag
do
    # shellcheck disable=SC2220
    case "${flag}" in
        p) PROJECT=${OPTARG};;
        s) STORAGE_CLS=${OPTARG};;
        r) DOCKER_REPO=${OPTARG};;
        h) PROTOCOL=${OPTARG};;
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

if [ -z "$DOCKER_REPO" ]; then
    echo "Warning || Parameter -r : DOCKER_REPO name is empty"
fi

oc project $PROJECT

oc process -f stateful-template.yaml -p STORAGE_CLS=$STORAGE_CLS -p DOCKER_REPO=$DOCKER_REPO | oc create -f -

oc apply -f service.yaml

NAME="pgadmin"

if [[ "$PROTOCOL" == "https" ]]; then
    oc create route edge --service=$NAME  # for ssl/https
else
    oc expose svc/$NAME
fi