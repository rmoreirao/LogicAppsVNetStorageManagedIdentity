param sites_logicappsrm1manual_name string = 'logicappsrm1manual'
param serverfarms_manualhostingplan_externalid string = '/subscriptions/b0dfd5b3-9f3c-4fb5-ae5e-0e7f81eab970/resourceGroups/rg-manual-logic-apps/providers/Microsoft.Web/serverfarms/manualhostingplan'
param virtualNetworks_vnetrmkv01_externalid string = '/subscriptions/b0dfd5b3-9f3c-4fb5-ae5e-0e7f81eab970/resourceGroups/rg-logic-apps-internal-kv/providers/Microsoft.Network/virtualNetworks/vnetrmkv01'

resource sites_logicappsrm1manual_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_logicappsrm1manual_name
  location: 'UK South'
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_logicappsrm1manual_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_logicappsrm1manual_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    
    serverFarmId: serverfarms_manualhostingplan_externalid
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: true
    vnetImagePullEnabled: false
    vnetContentShareEnabled: true
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
      appSettings: [
        
          {
            name: 'APP_KIND'
            value: 'workflowApp'
          }
          {
            name: 'AzureFunctionsJobHost__extensionBundle__id'
            value: 'Microsoft.Azure.Functions.ExtensionBundle.Workflows'
          }
          {
            name: 'AzureFunctionsJobHost__extensionBundle__version'
            value: '[1.*, 2.0.0)'
          }
          {
            name: 'AzureWebJobsStorage'
            value: '@Microsoft.KeyVault(VaultName=kv-logicapps-public;SecretName=StorageKey)'
          }
          {
            name: 'FUNCTIONS_EXTENSION_VERSION'
            value: '~4'
          }
          {
            name: 'FUNCTIONS_WORKER_RUNTIME'
            value: 'node'
          }
          {
            name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
            value: '@Microsoft.KeyVault(VaultName=kv-logicapps-public;SecretName=StorageKey)'
          }
          {
            name: 'WEBSITE_CONTENTSHARE'
            value: 'logicappsrm1manuala8f1'
          }
          {
            name: 'WEBSITE_NODE_DEFAULT_VERSION'
            value: '~18'
          }
           //https://learn.microsoft.com/en-us/azure/app-service/app-service-key-vault-references?tabs=azure-cli#granting-your-app-access-to-key-vault
           {
            name: 'WEBSITE_SKIP_CONTENTSHARE_VALIDATION'
            value: '1'
          }

          
          // {
          //   name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          //   value: appInsights.properties.InstrumentationKey
          // }
          // {
          //   name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          //   value: appInsights.properties.ConnectionString
          // }
          
         
           // https://learn.microsoft.com/en-us/azure/app-service/app-service-key-vault-references?tabs=azure-cli#granting-your-app-access-to-key-vault
          //  {
          //   name: 'WEBSITE_SKIP_CONTENTSHARE_VALIDATION'
          //   value: '1'
          // }
          
      ]
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '82D19E89D2FB77F5933E38AFB449F99B9FCE6EB5963E7D21E9A10F2BFC44F90E'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Disabled'
    storageAccountRequired: false
    virtualNetworkSubnetId: '${virtualNetworks_vnetrmkv01_externalid}/subnets/subnetoutbound'
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_logicappsrm1manual_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: 'ftp'
  location: 'UK South'
  properties: {
    allow: false
  }
}

resource sites_logicappsrm1manual_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: 'scm'
  location: 'UK South'
  properties: {
    allow: false
  }
}

resource sites_logicappsrm1manual_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: 'web'
  location: 'UK South'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v6.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetName: 'c662887d-1e47-4691-8ad9-d31a6d52c0fa_subnetoutbound'
    vnetRouteAllEnabled: true
    vnetPrivatePortsCount: 2
    publicNetworkAccess: 'Disabled'
    cors: {
      supportCredentials: false
    }
    localMySqlEnabled: false
    managedServiceIdentityId: 17667
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: true
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_logicappsrm1manual_name_sites_logicappsrm1manual_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: '${sites_logicappsrm1manual_name}.azurewebsites.net'
  location: 'UK South'
  properties: {
    siteName: 'logicappsrm1manual'
    hostNameType: 'Verified'
  }
}

resource sites_logicappsrm1manual_name_peplogicapps_c0d1b1dd_f4c3_45bf_a805_ee24744cb362 'Microsoft.Web/sites/privateEndpointConnections@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: 'peplogicapps-c0d1b1dd-f4c3-45bf-a805-ee24744cb362'
  location: 'UK South'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      actionsRequired: 'None'
    }
    ipAddresses: [
      '10.100.1.11'
    ]
  }
}

resource sites_logicappsrm1manual_name_c662887d_1e47_4691_8ad9_d31a6d52c0fa_subnetoutbound 'Microsoft.Web/sites/virtualNetworkConnections@2023-12-01' = {
  parent: sites_logicappsrm1manual_name_resource
  name: 'c662887d-1e47-4691-8ad9-d31a6d52c0fa_subnetoutbound'
  location: 'UK South'
  properties: {
    vnetResourceId: '${virtualNetworks_vnetrmkv01_externalid}/subnets/subnetoutbound'
    isSwift: true
  }
}
