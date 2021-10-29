#!/bin/bash

# Create the bitbucket project
oc new-project bitbucket

# Switch to the bitbucket project
oc project bitbucket

# Create the postgres database
oc create -f ./postgres.yaml

echo "Waiting for postgres to deploy"
sleep 15

# Bitbucket needs a secret for accessing the postgresql database
oc create secret generic postgres --from-literal=username=jirauser --from-literal=password=jirapassword
sleep 2

# Create Service Accounts and roles for bitbucket
oc create -f ./roles.yaml
sleep 2

# Create persistant volumes for bitbucket
oc create -f ./volumes.yaml
sleep 2

