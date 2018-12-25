#!/bin/bash
# Setup Production Project (initial active services: Green)
if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "  $0 GUID"
    exit 1
fi

GUID=$1
echo "Setting up Parks Production Environment in project ${GUID}-parks-prod"

# Code to set up the parks production project. It will need a StatefulSet MongoDB, and two applications each (Blue/Green) for NationalParks, MLBParks and Parksmap.
# The Green services/routes need to be active initially to guarantee a successful grading pipeline run.

# To be Implemented by Student
oc project ${GUID}-parks-prod

oc policy add-role-to-group system:image-puller system:serviceaccounts:4d09-parks-prod -n 4d09-parks-dev

oc policy add-role-to-user edit system:serviceaccount:4d09-jenkins:jenkins -n 4d09-parks-prod

oc policy add-role-to-user view --serviceaccount=default -n 4d09-parks-prod

oc process -f ./Infrastructure/templates/parks-prod.yaml | oc create -f - -n ${GUID}-parks-prod
