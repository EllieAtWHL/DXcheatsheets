({
	onSearch : function(component, event, helper) {
        var action=component.get("c.getBoats");
        action.setParams({ boatTypeId: component.get("v.boatTypeId")});
        action.setCallback(this,function(response) {
            if(response.getState === 'SUCCESS'){
                var boatslist = response.getReturnValue();
                component.set("v.boats",boatslist);
            }  
        });
        $A.enqueueAction(action);		
	}
})