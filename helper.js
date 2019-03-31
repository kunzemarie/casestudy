({
	mAction : function(component, event, helper) {
		var action = component.get("c.getCost");
		action.setParams({
    	recordId: component.get("v.recordId")
		});
		action.setCallback(this, function(data) {
    	component.set("v.Cost", data.getReturnValue());
		});
		$A.enqueueAction(action);

    component.set("v.Columns1", [
    	{label:"Cost per Calendar Month", fieldName:"Name", type:"text"},
      {label:"Price", fieldName:"Price1__c", type:"number"}
		]);
		component.set("v.Columns2", [
			{label:"ATM Fee in other currencies", fieldName:"Name", type:"text"},
			{label:"Price", fieldName:"Price2__c", type:"number"}
		]);
		component.set("v.Columns3", [
			{label:"Card Replacement Cost", fieldName:"Name", type:"text"},
			{label:"Price", fieldName:"Price3__c", type:"number"}
		]);
	}
})
