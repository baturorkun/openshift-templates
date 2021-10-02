#!/usr/bin/env bash

### ENVs
echo "Getting parameters"
while getopts s:r: flag
do
    # shellcheck disable=SC2220
    case "${flag}" in
        p) PROJECT=${OPTARG};;
        s) STORAGE_CLS=${OPTARG};;
        r) DOCKER_REPO=${OPTARG};;
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

oc process -f stateful-template.yaml -p STORAGE_CLS=$STORAGE_CLS -p DOCKER_REPO=$DOCKER_REPO | oc delete -f -
oc delete -f service.yaml
oc delete route pgadmin