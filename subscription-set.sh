az login
az account list --output table   
az account set --subscription  e65c5b52-7f17-43e2-851c-0fada7d75bec

# Open the tunnel to your target VM using the following command:

az network bastion tunnel --name "examplebastion" --resource-group "poc-dtp" --target-resource-id "/subscriptions/376115ad-64da-4d14-ad2a-b8265f54b652/resourceGroups/poc-dtp/providers/Microsoft.Compute/virtualMachines/my-dtp-server" --resource-port "22" --port "50022"

# Open a second command prompt to connect to your target VM through the tunnel. In this second command prompt window, you can upload files from your local machine to your target VM using the following command:

scp -P <LocalMachinePort>  <local machine file path>  <username>@127.0.0.1:<target VM file path>
scp -i "files/ssh-key" -P 50022 create-mysql-database.sh  azureuser@127.0.0.1:~
# Connect to your target VM using SSH or RDP, the native client of your choice, and the local machine port you specified in Step 3.
# For example, you can use the following command if you have the OpenSSH client installed on your local computer:

ssh <username>@127.0.0.1 -p <LocalMachinePort>
ssh -i "files/ssh-key" azureuser@127.0.0.1 -p 50022

ssh -i "deploy-credentials/ssh-key" azureuser@127.0.0.1 -p 50022

