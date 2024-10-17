param virtualNetworks_vnetrmkv01_name string = 'vnetrmkv01'

resource virtualNetworks_vnetrmkv01_name_resource 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: virtualNetworks_vnetrmkv01_name
  location: 'uksouth'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.100.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet1'
        id: virtualNetworks_vnetrmkv01_name_Subnet1.id
        properties: {
          addressPrefix: '10.100.0.0/24'
          delegations: [
            {
              name: 'webapp'
              id: '${virtualNetworks_vnetrmkv01_name_Subnet1.id}/delegations/webapp'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        id: virtualNetworks_vnetrmkv01_name_AzureBastionSubnet.id
        properties: {
          addressPrefix: '10.100.2.0/26'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'contentstoragermkv01'
        id: virtualNetworks_vnetrmkv01_name_contentstoragermkv01.id
        properties: {
          addressPrefix: '10.100.1.0/24'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'subnetoutbound'
        id: virtualNetworks_vnetrmkv01_name_subnetoutbound.id
        properties: {
          addressPrefix: '10.100.3.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'uksouth'
                'ukwest'
              ]
            }
          ]
          delegations: [
            {
              name: 'delegation'
              id: '${virtualNetworks_vnetrmkv01_name_subnetoutbound.id}/delegations/delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnetrmkv01_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_vnetrmkv01_name}/AzureBastionSubnet'
  properties: {
    addressPrefix: '10.100.2.0/26'
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnetrmkv01_name_resource
  ]
}

resource virtualNetworks_vnetrmkv01_name_contentstoragermkv01 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_vnetrmkv01_name}/contentstoragermkv01'
  properties: {
    addressPrefix: '10.100.1.0/24'
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnetrmkv01_name_resource
  ]
}

resource virtualNetworks_vnetrmkv01_name_Subnet1 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_vnetrmkv01_name}/Subnet1'
  properties: {
    addressPrefix: '10.100.0.0/24'
    delegations: [
      {
        name: 'webapp'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnetrmkv01_name_subnetoutbound 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_vnetrmkv01_name}/subnetoutbound'
  properties: {
    addressPrefix: '10.100.3.0/24'
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
        locations: [
          'uksouth'
          'ukwest'
        ]
      }
    ]
    delegations: [
      {
        name: 'delegation'
        id: '${virtualNetworks_vnetrmkv01_name_subnetoutbound.id}/delegations/delegation'
        properties: {
          serviceName: 'Microsoft.Web/serverfarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnetrmkv01_name_resource
  ]
}
