#!/bin/bash

az network bastion tunnel --name "examplebastion" --resource-group "POC-Bastion-Host" --target-resource-id "/subscriptions/4307d060-3d4f-42dd-a5f8-5d44cd11f167/resourceGroups/POC-Bastion-Host/providers/Microsoft.Compute/virtualMachines/my-server" --resource-port "22" --port "50022" > /dev/null 2>&1 & 

echo "sleep 3 seconds"
sleep 3

echo "Executing secure copy"
scp -i "files/ssh-key" -P 50022 README.md azureuser@127.0.0.1:~
scp -i "files/ssh-key" -P 50022 variables.tf azureuser@127.0.0.1:~

echo "sleep 1"
sleep 1

kill -9 $(lsof -i -P -n | grep "$(whoami)" | grep "50022" | grep "TCP" | tr -s " " | cut -d " " -f 2)


#sudo lsof -i -P -n | grep LISTEN
