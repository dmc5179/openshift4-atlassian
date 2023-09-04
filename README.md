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

Use the README file in each application directory like confluence or bitbucket for steps to deploy those
