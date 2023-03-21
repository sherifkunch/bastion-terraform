#!/bin/bash

az network bastion tunnel --name "examplebastion" --resource-group "poc-dtp" --target-resource-id "/subscriptions/376115ad-64da-4d14-ad2a-b8265f54b652/resourceGroups/poc-dtp/providers/Microsoft.Compute/virtualMachines/my-dtp-server" --resource-port "22" --port "50022" > /dev/null 2>&1 & 

echo "sleep 3 seconds"
sleep 3

echo "Executing secure copy"
scp -i "files/ssh-key" -P 50022 README.md azureuser@127.0.0.1:~
scp -i "files/ssh-key" -P 50022 variables.tf azureuser@127.0.0.1:~

echo "sleep 1"
sleep 1

kill -9 $(lsof -i -P -n | grep "$(whoami)" | grep "50022" | grep "TCP" | tr -s " " | cut -d " " -f 2)


#sudo lsof -i -P -n | grep LISTEN
