#!/bin/bash

# Switch to the bitbucket project
oc project jira

POSTGRES_POD=$(oc get pods | grep postgres | awk '{print $1}')

oc rsh ${POSTGRES_POD} psql -h localhost -p 5432 -U postgres -c 'create database jira;'

oc rsh ${POSTGRES_POD} psql -h localhost -p 5432 -U postgres -c 'grant all privileges on database jira to jirauser;'

# Bitbucket needs a secret for accessing the postgresql database
# TODO: Should this user be the same as the one above? postgres
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

helm install jira atlassian-data-center/jira --namespace jira --values values.yaml
