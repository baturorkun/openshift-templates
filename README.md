## Openshift Templates

## Postgres
###### Script Name: 

**postgres/apply.sh**

###### Parameters: 
* **-p** : Project Name ( Namespace )  (Required)
* **-s** : Storage Name (Required)
* **-r** : Docker registry name ( Not Required )
* **-n** : Node Port  (Required)

###### Example:

```
./apply.sh  -p demo -s mystorage -r nexus.domain.com/ -n 30001
```

## Pgadmin
###### Script Name:

**pgadmin/apply.sh**

###### Parameters:
* **-p** : Project Name ( Namespace )  (Required)
* **-s** : Storage Name (Required)
* **-r** : Docker registry name ( Not Required )
* **-n** : Protocol  (Required)

###### Example:

```
./apply.sh  -p demo -s mystorage -r nexus.domain.com/ -h https
```
