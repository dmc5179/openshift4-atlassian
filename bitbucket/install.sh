#!/bin/bash

# Switch to the bitbucket project
oc project jira

# Create the postgres database
oc create -f ./postgres.yaml

echo "Waiting for postgres to deploy"
sleep 15

POSTGRES_POD=$(oc get pods | grep postgres | awk '{print $1}')
oc rsh "${POSTGRES_POD}" psql -h localhost -p 5432 -U admin -p jiraadminpassword -c 'create database bibucket;'

# Bitbucket needs a secret for accessing the postgresql database
oc create secret generic postgres --from-literal=username=jirauser --from-literal=password=jirapassword
sleep 2

# Create Service Accounts for bitbucket
oc create -f ./serviceaccounts.yaml
sleep 2

# Create Role Bindings for bitbucket service accounts
oc create -f ./rolebindings.yaml

# Create persistant volumes for bitbucket
oc create -f ./volumes.yaml
sleep 2

helm install bitbucket atlassian-data-center/bitbucket --namespace jira --values values.yaml
