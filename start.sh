#!/bin/bash
PARAM_LENGTH=$#

help_text () {
    echo "Wrong Number of arguments, USAGE:"
    echo "./start.sh resourceGroupName"
}

function prepare_image_name () {
    PREFIX="dev_packer_image"
    timestamp=$(date +%Y%m%d%h%M%s)
    IMAGE_NAME=${PREFIX}$timestamp
}

if [ $PARAM_LENGTH -lt 1 ]
then
    help_text
    exit 0
fi

RG_NAME=$1
prepare_image_name
az group create -n $RG_NAME -l northeurope

#Create packer image
#packer build -var azure_resource_group=$RG_NAME -var azure_image_name=$IMAGE_NAME packer_image.json

#Create test VM from the generated packer image
az deployment group create --resource-group $RG_NAME --template-file deploy_vm.json --parameters private.parameters.json






