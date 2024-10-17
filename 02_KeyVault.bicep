param vaults_kv_logicapps_public_name string = 'kv-logicapps-public'

resource vaults_kv_logicapps_public_name_resource 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: vaults_kv_logicapps_public_name
  location: 'uksouth'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'b9e20f22-cdf3-4d31-9628-2e615edcddb1'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true
    vaultUri: 'https://${vaults_kv_logicapps_public_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Disabled'
  }
}

resource vaults_kv_logicapps_public_name_pep_kv 'Microsoft.KeyVault/vaults/privateEndpointConnections@2024-04-01-preview' = {
  parent: vaults_kv_logicapps_public_name_resource
  name: 'pep-kv'
  location: 'uksouth'
  properties: {
    provisioningState: 'Succeeded'
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      actionsRequired: 'None'
    }
  }
}

resource vaults_kv_logicapps_public_name_StorageKey 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_kv_logicapps_public_name_resource
  name: 'StorageKey'
  location: 'uksouth'
  properties: {
    attributes: {
      enabled: true
    }
  }
}
