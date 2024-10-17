param serverfarms_manualhostingplan_name string = 'manualhostingplan'

resource serverfarms_manualhostingplan_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_manualhostingplan_name
  location: 'UK South'
  sku: {
    name: 'WS1'
    tier: 'WorkflowStandard'
    size: 'WS1'
    family: 'WS'
    capacity: 1
  }
  kind: 'elastic'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: true
    maximumElasticWorkerCount: 20
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}
