#!/bin/bash

POSTGRES_POD=$(oc get pods | grep postgres | awk '{print $1}')

oc rsh ${POSTGRES_POD} psql -h localhost -p 5432 -U postgres -c 'create database confluence;'

oc rsh ${POSTGRES_POD} psql -h localhost -p 5432 -U postgres -c 'grant all privileges on database confluence to jirauser;'

oc create -f ./serviceaccounts.yaml 
sleep 2

oc create -f ./rolebindings.yaml
sleep 2

oc create -f ./volumes.yaml
sleep 2

oc adm policy add-scc-to-user anyuid -z default

helm install confluence atlassian-data-center/confluence --namespace jira --values values.yaml


