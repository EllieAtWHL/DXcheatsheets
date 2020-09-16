({
    doInit: function(component,event,helper) 
    {
        helper.loadBoatTypes(component);
    }, 
    onFormSubmit: function (component,event,helper){
        var selectedType = component.get("v.selectedType");
        console.log('Search clicked: ' + selectedType);
    },
                            
    createBoat: function (component) 
    {
        console.log('inside controller');
        var createRecordEvent = $A.get('e.force:createRecord');
        if (createRecordEvent) 
        {
            var typeName = component.find('typeSelect').get('v.value');
            var typeMap = component.get('v.searchOptionToIdMap');
            var typeId = null;
            if (typeName && typeMap && typeMap[typeName]) 
            {
                typeId = typeMap[typeName];
            }
            createRecordEvent.setParams({
                'entityApiName': 'Boat__c',
                'defaultFieldValues': {
                    'BoatType__c': typeId
                }
            });
            createRecordEvent.fire();
        }
    }
})