#!/bin/bash

# Create the bitbucket project
oc new-project jira

# Switch to the bitbucket project
oc project jira

# Create the shared volume
oc create -f ./volumes.yaml
