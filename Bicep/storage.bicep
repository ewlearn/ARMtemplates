param location string = resourceGroup().location

@minLength(3)
@maxLength(24)
param name string = 'ewlearn'

@allowed( [ 
'Premium_LRS'
'Premium_ZRS'
'Standard_GRS'
'Standard_LRS'
'Standard_RAGRS'
'Standard_ZRS'
])
param type string = 'Standard_LRS'

var containerName = 'images'

resource stacc 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: name  
  location: location
  kind:'StorageV2'
  sku: {
    name: type
    
  }
}
resource container 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  name:'${stacc.name}/default/${containerName}'
}

output storageId string = stacc.id
