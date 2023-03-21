#!/bin/bash#return a list of all the secret IDs in your KeyVault
az keyvault secret list --vault-name keyvault-testo --query "[].id"
#loop will iterate through each secret ID and use the az keyvault secret show command to extract its value. The value is then exported as an environment variable with the secret name as the variable name.
for secret_id in $(az keyvault secret list --vault-name keyvault-testo --query "[].id" ); do
    secret_value=$(az keyvault secret show --id $secret_id --query "value" )
    # Export the secret value as an environment variable 
    export $(basename $secret_id)="$secret_value"
done
env