# Description:
## Purpose:
Working with software developers, they sometimed ask for access to a VM used in build system because they want to exclude even the minor possibilities of environment differences.

Sometimes, it is enough to give a docker image (if applicable) and they are happy. In some scenerios, I feel like giving them the opportunity to create  replica of a VM in question. Ideally, they should be able to create it with a single click and be able to decommission it whenever done, to save money.

This project can be used as a blue print of this concept.

## What is in it:
You can create a customized image using hashicrop packer. Use this image as source to spin up resources in your build environment (like agents).

Use (in this case azure being the cloud used) ARM templates to spin up a VM based on above image but with your credentials. 

Decomission the VM, using azure command line as described later.

# Pre Requisite:
* You need Azure Subscription.
* It is assumed that you are logged into azure portal. 
* [az login](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli)


## Create a packer image
Update the provisioning or anything else in the code and run the script "start.sh" to create a new packer image.

### Usage
Run the launcher script

```bash
create_packer_image.sh RESOURCEGROUP_NAME
```
It creates the resourceGroup if it is not already there.


## Create a VM from packar image
Fill in the values in the parameter file "deploy_vm.parameters.json" and run the following commands in sequence.

The *deploy_vm.parameters.json* file is empty since I did not want to post any personal values on github public repo. However, in a private repo, most values can still be checked into repo. 

```bash
az group create -n myresourcegroupname -l northeurope
az deployment group create --resource-group myresourcegroupname --template-file deploy_vm.json --parameters deploy_vm.parameters.json
```
**Note:** choose a meaningful name instead of "myresourcegroupname".

Access the machine, either by getting IP via Azure portal or the ARM template outputs pvtIP as to console, look for: _"privateIPAddress":_ or can use the following command to get IP address.
```bash
az deployment group show -g myawesomergname -n deploy_vm --query properties.outputs.networkInterface.value.ipConfigurations[0].properties.privateIPAddress
```



