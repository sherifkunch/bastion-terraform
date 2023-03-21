#!/bin/bash

source mysql-db.var

az mysql flexible-server create \
    --location $AZ_LOCATION \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_DATABASE_SERVER_NAME \
    --admin-user $AZ_MYSQL_ADMIN_USERNAME \
    --admin-password $AZ_MYSQL_ADMIN_PASSWORD \
    --sku-name Standard_B1ms \
    --tier Burstable \
    --public-access 0.0.0.0 \
    --storage-size 32 \
    --tags "key=value" \
    --version 8.0.21


#Configure a firewall rule for you MySQL server 
az mysql flexible-server firewall-rule create \
    --resource-group $AZ_RESOURCE_GROUP \
    --rule-name $AZ_DATABASE_SERVER_NAME-database-allow-local-ip \
    --name $AZ_DATABASE_SERVER_NAME \
    --start-ip-address $START_IP_ADDRESS \
    --end-ip-address $END_IP_ADDRESS \
    --output tsv
    
#how to connect 
#az mysql flexible-server connect -n $AZ_DATABASE_SERVER_NAME -u $AZ_MYSQL_ADMIN_USERNAME -p  $AZ_MYSQL_ADMIN_PASSWORD -d 

#how to delete
#az mysql flexible-server delete --resource-group $AZ_RESOURCE_GROUP --name $AZ_DATABASE_SERVER_NAME
