# Commands to access and manage the postgres cluster

```
PG_CLUSTER_PRIMARY_POD=$(oc -n atlassian get pod -o name -l postgres-operator.crunchydata.com/cluster=hippo,postgres-operator.crunchydata.com/role=master)
```

```
oc -n atlassian port-forward "${PG_CLUSTER_PRIMARY_POD}" 5432:5432
```

```
oc -n atlassian get secrets hippo-pguser-hippo -o go-template='{{.data.uri | base64decode}}'
```
