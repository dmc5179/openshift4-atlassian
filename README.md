# openshift4-atlassian

# Create the bitbucket project
```
oc new-project jira
```

# Switch to the bitbucket project
```
oc project jira
```

# Create the shared volume
```
oc create -f ./shared/volumes.yaml
```

# Create postgres database
```
oc create -f ./shared/postgres.yaml
```

# Create postgresql jirauser
```
POSTGRES_POD=$(oc get pods | grep postgres | awk '{print $1}')
oc rsh ${POSTGRES_POD} psql -h localhost -p 5432 -U postgres -c "create user jirauser with password 'jirapassword';"
```

Use the README file in each application directory like confluence or bitbucket for steps to deploy those
