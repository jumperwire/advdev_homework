#!/bin/bash
# Setup Development Project
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 GUID"
    exit 1
fi

GUID=$1
echo "Setting up Parks Development Environment in project ${GUID}-parks-dev"

# Code to set up the parks development project.

# To be Implemented by Student
oc new-project ${GUID}-parks-dev --display-name "Development Environment"

oc policy add-role-to-user edit system:serviceaccount:${GUID}-jenkins:jenkins -n ${GUID}-parks-dev

oc policy add-role-to-user view --serviceaccount=default -n 4d09-parks-dev

oc process -f ./Infrastructure/templates/parks-dev.yaml | oc create -f - -n ${GUID}-parks-dev
