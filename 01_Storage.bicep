param storageAccounts_stgmanuallogicappsrm_name string = 'stgmanuallogicappsrm'

resource storageAccounts_stgmanuallogicappsrm_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_stgmanuallogicappsrm_name
  location: 'uksouth'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      resourceAccessRules: [
        {
          tenantId: 'b9e20f22-cdf3-4d31-9628-2e615edcddb1'
          resourceId: '/subscriptions/b0dfd5b3-9f3c-4fb5-ae5e-0e7f81eab970/providers/Microsoft.Security/datascanners/StorageDataScanner'
        }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
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
    accessTier: 'Hot'
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stgmanuallogicappsrm_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_storageAccounts_stgmanuallogicappsrm_name_345ebc9a_31c0_4568_a289_76c3e700d5e9 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: '${storageAccounts_stgmanuallogicappsrm_name}.345ebc9a-31c0-4568-a289-76c3e700d5e9'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_storageAccounts_stgmanuallogicappsrm_name_66bcff5c_f4a0_4d55_a654_bd8321da8b10 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: '${storageAccounts_stgmanuallogicappsrm_name}.66bcff5c-f4a0-4d55-a654-bd8321da8b10'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_storageAccounts_stgmanuallogicappsrm_name_bb9693df_642e_441d_9b0a_36af60f8ca8d 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: '${storageAccounts_stgmanuallogicappsrm_name}.bb9693df-642e-441d-9b0a-36af60f8ca8d'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_storageAccounts_stgmanuallogicappsrm_name_ca7c6415_eb75_4dac_a0ba_0c3bd2532702 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: '${storageAccounts_stgmanuallogicappsrm_name}.ca7c6415-eb75-4dac-a0ba-0c3bd2532702'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_storageAccounts_stgmanuallogicappsrm_name_f218fd67_6661_435f_9883_397b6961171a 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: '${storageAccounts_stgmanuallogicappsrm_name}.f218fd67-6661-435f-9883-397b6961171a'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stgmanuallogicappsrm_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgmanuallogicappsrm_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_stgmanuallogicappsrm_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stgmanuallogicappsrm_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_logicappsrm1manuala8f1 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'logicappsrm1manuala8f1'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_flow465ac629d824f3ajobtriggers00 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'flow465ac629d824f3ajobtriggers00'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_AzureFunctionsScaleMetrics202410 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'AzureFunctionsScaleMetrics202410'
  properties: {}
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_flow465ac629d824f3aflowsubscriptions 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'flow465ac629d824f3aflowsubscriptions'
  properties: {}
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_flow465ac629d824f3ajobdefinitions 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'flow465ac629d824f3ajobdefinitions'
  properties: {}
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}

resource storageAccounts_stgmanuallogicappsrm_name_default_flow465ac629d824f3aworkeraffinitylistenercertificates 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stgmanuallogicappsrm_name_default
  name: 'flow465ac629d824f3aworkeraffinitylistenercertificates'
  properties: {}
  dependsOn: [
    storageAccounts_stgmanuallogicappsrm_name_resource
  ]
}
