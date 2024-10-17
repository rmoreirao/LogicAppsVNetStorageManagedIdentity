// https://learn.microsoft.com/en-us/azure/app-service/app-service-key-vault-references?tabs=azure-cli#granting-your-app-access-to-key-vault
// az group create --name rg-logic-apps-internal-kv --location uksouth
// az deployment group create --resource-group rg-logic-apps-internal-kv --template-file main3-keyvault.bicep --parameters main3-keyvault.bicepparam

using './main3-keyvault.bicep'

var suffix = 'rmkv01'

param logicAppFEname = 'logicappfe${suffix}'
param fileShareName  = 'fileshare${suffix}'
param location = 'uksouth'
param use32BitWorkerProcess = true
param hostingPlanFEName  = 'hostingplanfe${suffix}'
param contentStorageAccountName = 'contentstorage${suffix}'
param sku  = 'WorkflowStandard'
param skuCode = 'WS1'
param numberOfWorkers = '1'
param vnetName  = 'vnet${suffix}'
param subnetName = 'Subnet1'
param virtualNetworkAddressPrefix = '10.100.0.0/16'
param functionSubnetAddressPrefix = '10.100.0.0/24'
param privateEndpointSubnetAddressPrefix = '10.100.1.0/24'
