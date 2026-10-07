({
    handleSubmit : function(component, event, helper) {
        var action = component.get("c.createContact");
        action.setParams({
            firstName: component.get("v.firstName"),
            lastName: component.get("v.lastName"),
            email: component.get("v.email")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.message", response.getReturnValue());
                // Clear form after success
                component.set("v.firstName", "");
                component.set("v.lastName", "");
                component.set("v.email", "");
            } else {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    component.set("v.message", "Error: " + errors[0].message);
                } else {
                    component.set("v.message", "Unknown error occurred.");
                }
            }
        });
        $A.enqueueAction(action);
    }
})