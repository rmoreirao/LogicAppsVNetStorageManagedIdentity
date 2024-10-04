param logicAppFEname string
param fileShareName string
param use32BitWorkerProcess bool
param location string = resourceGroup().location
param hostingPlanFEName string
param contentStorageAccountName string
param sku string
param skuCode string
param numberOfWorkers string
param vnetName string = 'VirtualNetwork'
param subnetName string
param virtualNetworkAddressPrefix string = '10.100.0.0/16'
param functionSubnetAddressPrefix string = '10.100.0.0/24'
param privateEndpointSubnetAddressPrefix string = '10.100.1.0/24'

var privateStorageFileDnsZoneName = 'privatelink.file.${environment().suffixes.storage}'
var privateStorageBlobDnsZoneName = 'privatelink.blob.${environment().suffixes.storage}'
var privateStorageQueueDnsZoneName = 'privatelink.queue.${environment().suffixes.storage}'
var privateStorageTableDnsZoneName = 'privatelink.table.${environment().suffixes.storage}'
var privateEndpointFileStorageName = '${contentStorageAccountName}-file-private-endpoint'
var privateEndpointBlobStorageName = '${contentStorageAccountName}-blob-private-endpoint'
var privateEndpointQueueStorageName = '${contentStorageAccountName}-queue-private-endpoint'
var privateEndpointTableStorageName = '${contentStorageAccountName}-table-private-endpoint'
var virtualNetworkLinksSuffixFileStorageName = '${privateStorageFileDnsZoneName}-link'
var virtualNetworkLinksSuffixBlobStorageName = '${privateStorageBlobDnsZoneName}-link'
var virtualNetworkLinksSuffixQueueStorageName = '${privateStorageQueueDnsZoneName}-link'
var virtualNetworkLinksSuffixTableStorageName = '${privateStorageTableDnsZoneName}-link'

resource vnet 'Microsoft.Network/virtualNetworks@2020-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: functionSubnetAddressPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          delegations: [
            {
              name: 'webapp'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
      {
        name: contentStorageAccountName
        properties: {
          addressPrefix: privateEndpointSubnetAddressPrefix
          privateLinkServiceNetworkPolicies: 'Enabled'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: contentStorageAccountName
  location: location
  dependsOn: [
    vnet
  ]
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${contentStorageAccountName}/default/${toLower(fileShareName)}'
  dependsOn: [
    storageAccount
  ]
}

resource privateDnsZoneFile 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageFileDnsZoneName
  location: 'global'
  dependsOn: [
    vnet
  ]
}

resource privateDnsZoneBlob 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageBlobDnsZoneName
  location: 'global'
  dependsOn: [
    vnet
  ]
}

resource privateDnsZoneQueue 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageQueueDnsZoneName
  location: 'global'
  dependsOn: [
    vnet
  ]
}

resource privateDnsZoneTable 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageTableDnsZoneName
  location: 'global'
  dependsOn: [
    vnet
  ]
}

resource vnetLinkFile 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZoneFile
  name: virtualNetworkLinksSuffixFileStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource vnetLinkBlob 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZoneBlob
  name: virtualNetworkLinksSuffixBlobStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource vnetLinkQueue 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZoneQueue
  name: virtualNetworkLinksSuffixQueueStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource vnetLinkTable 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZoneTable
  name: virtualNetworkLinksSuffixTableStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource privateEndpointFile 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointFileStorageName
  location: location
  dependsOn: [
    fileShare
    vnet
  ]
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, contentStorageAccountName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageQueuePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'file'
          ]
        }
      }
    ]
  }
}

resource privateEndpointBlob 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointBlobStorageName
  location: location
  dependsOn: [
    fileShare
    vnet
  ]
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, contentStorageAccountName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageQueuePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

resource privateEndpointQueue 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointQueueStorageName
  location: location
  dependsOn: [
    fileShare
    vnet
  ]
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, contentStorageAccountName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageQueuePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'queue'
          ]
        }
      }
    ]
  }
}

resource privateEndpointTable 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointTableStorageName
  location: location
  dependsOn: [
    fileShare
    vnet
  ]
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, contentStorageAccountName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageQueuePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'table'
          ]
        }
      }
    ]
  }
}

resource privateDnsZoneGroupFile 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointFile
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneFile.id
        }
      }
    ]
  }
}

resource privateDnsZoneGroupBlob 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointBlob
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneBlob.id
        }
      }
    ]
  }
}

resource privateDnsZoneGroupQueue 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointQueue
  name: 'default'
  dependsOn: [
  ]
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneQueue.id
        }
      }
    ]
  }
}

resource privateDnsZoneGroupTable 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointTable
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZoneTable.id
        }
      }
    ]
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: logicAppFEname
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource logicApp 'Microsoft.Web/sites@2018-11-01' = {
  name: logicAppFEname
  location: location
  tags: {}
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    siteConfig: {
      numberOfWorkers: int(numberOfWorkers)

      appSettings: [
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'node'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        // {
        //   name: 'AzureWebJobsStorage'
        //   value: 'DefaultEndpointsProtocol=https;AccountName=${contentStorageAccountName};AccountKey=${listKeys(storageAccount.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        // }
        {
          name: 'AzureWebJobsStorage__accountName'
          value: storageAccount.name
        }
        {
          name: 'AzureWebJobsStorage__blobServiceUri'
          value: storageAccount.properties.primaryEndpoints.blob
        }
        // {
        //   name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
        //   value: 'DefaultEndpointsProtocol=https;AccountName=${contentStorageAccountName};AccountKey=${listKeys(storageAccount.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        // }
        // {
        //   name: 'WEBSITE_CONTENTSHARE'
        //   value: toLower(fileShareName)
        // }
        {
          name: 'APP_KIND'
          value: 'workflowApp'
        }
        {
          name: 'WEBSITE_VNET_ROUTE_ALL'
          value: '1'
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__id'
          value: 'Microsoft.Azure.Functions.ExtensionBundle.Workflows'
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__version'
          value: '[1.*, 2.0.0)'
        }
        // {
        //   name: 'WEBSITE_CONTENTOVERVNET'
        //   value: '1'
        // }
      ]
      use32BitWorkerProcess: use32BitWorkerProcess
      cors: {
        allowedOrigins: [
          'https://afd.hosting.portal.azure.net'
          'https://afd.hosting-ms.portal.azure.net'
          'https://hosting.portal.azure.net'
          'https://ms.hosting.portal.azure.net'
          'https://ema-ms.hosting.portal.azure.net'
          'https://ema.hosting.portal.azure.net'
          'https://ema.hosting.portal.azure.net'
        ]
      }
    }
    serverFarmId: resourceId('Microsoft.Web/serverfarms', hostingPlanFEName)
    clientAffinityEnabled: true

  }
}

// Assign the Logic App to the Storage Blob Data Contributor role
var roleDefinitionId = '/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe'
resource roleAuthorization 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  // Generate a unique but deterministic resource name
  name: guid('storage-rbac', storageAccount.id, resourceGroup().id, logicApp.id, roleDefinitionId)
  scope: storageAccount
  properties: {
      principalId: logicApp.identity.principalId
      roleDefinitionId: roleDefinitionId 
  }
}

// Assign the Logic App to the Storage Storage Contributor role
var role2 = '/providers/Microsoft.Authorization/roleDefinitions/17d1049b-9a84-46fb-8f53-869881c3d3ab'
resource roleAuthorization2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  // Generate a unique but deterministic resource name
  name: guid('storage-rbac', storageAccount.id, resourceGroup().id, logicApp.id, role2)
  scope: storageAccount
  properties: {
      principalType: 'ServicePrincipal'
    // logicApp system assigned identity id
      principalId: logicApp.identity.principalId
      roleDefinitionId: role2
  }
}


resource virtualNetwork 'Microsoft.Web/sites/networkconfig@2018-11-01' = {
  parent:  logicApp
  name: 'virtualNetwork'
  properties: {
    subnetResourceId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
    swiftSupported: true
  }
}

resource hostingPlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: hostingPlanFEName
  location: location
  tags: {}
  sku: {
    tier: sku
    name: skuCode
  }
  properties: {
  }
}
