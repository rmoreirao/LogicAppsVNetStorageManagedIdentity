// https://techcommunity.microsoft.com/t5/apps-on-azure-blog/use-managed-identity-instead-of-azurewebjobsstorage-to-connect-a/ba-p/3657606#:~:text=In%20a%20function%20app,%20usually%20we%20use%20appsetting
// az group create --name rg-logic-apps-internal-8 --location uksouth
// az deployment group create --resource-group rg-logic-apps-internal-8 --template-file main2.bicep --parameters main2.bicepparam

using './main2.bicep'

var suffix = 'rmoreiraouks08'

param logicAppFEname = 'logicappfe${suffix}'
param fileShareName  = 'fileshare${suffix}'
param location = 'uksouth'
param use32BitWorkerProcess = true
param hostingPlanFEName  = 'hostingplanfe${suffix}'
param contentStorageAccountName = 'storage${suffix}'
param sku  = 'Premium0V3'
param skuCode = 'P0V3'
param numberOfWorkers = '1'
param vnetName  = 'vnet${suffix}'
param subnetName = 'Subnet1'
param virtualNetworkAddressPrefix = '10.100.0.0/16'
param functionSubnetAddressPrefix = '10.100.0.0/24'
param privateEndpointSubnetAddressPrefix = '10.100.1.0/24'
