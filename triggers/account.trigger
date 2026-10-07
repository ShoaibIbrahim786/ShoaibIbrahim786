Trigger account on Account(before update, before insert){
/* Case Trigger
 trigger CaseTrigger on Case (before insert, before update, after update) {
    if (CaseTriggerHandler.isTriggerActive('CaseTrigger')) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                CaseTriggerHandler.beforeInsert(Trigger.new);
            }
            if (Trigger.isUpdate) {
                CaseTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
            }
        }
        if (Trigger.isAfter) {
            if (Trigger.isUpdate) {
                CaseTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
    }
}
Handler Class 

public class CaseTriggerHandler {

    // ✅ Method to check if trigger is active via Custom Metadata
    public static Boolean isTriggerActive(String triggerName) {
        Trigger_Switch__mdt config = [
            SELECT IsActive__c 
            FROM Trigger_Switch__mdt 
            WHERE DeveloperName = :triggerName 
            LIMIT 1
        ];
        return config != null && config.IsActive__c;
    }

    // ✅ Before Insert Logic
    public static void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            if (c.Priority == 'High') {
                c.Escalation_Flag__c = true;
            }
        }
    }

    // ✅ Before Update Logic
    public static void beforeUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        for (Case c : newCases) {
            Case oldCase = oldMap.get(c.Id);
            // Auto-set flag if Priority changed to High
            if (c.Priority == 'High' && oldCase.Priority != 'High') {
                c.Escalation_Flag__c = true;
            }
        }
    }

    // ✅ After Update Logic
    public static void afterUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        List<FeedItem> feedItems = new List<FeedItem>();
        for (Case c : newCases) {
            Case oldCase = oldMap.get(c.Id);
            // Post chatter message if manually escalated
            if (c.Escalation_Flag__c == true && oldCase.Escalation_Flag__c == false) {
                FeedItem post = new FeedItem();
                post.ParentId = c.Id;
                post.Body = 'Case has been manually escalated by user ' + UserInfo.getName() + '.';
                feedItems.add(post);
            }
        }
        if (!feedItems.isEmpty()) {
            insert feedItems;
        }
    }
}

*/

/* Creat Contact 
 

public with sharing class CreateContactController {
    @AuraEnabled
    public static String createContact(String firstName, String lastName, String email) {
        // Validate input on server side too (for safety)
        if (String.isBlank(firstName) || String.isBlank(lastName) || String.isBlank(email)) {
            throw new AuraHandledException('All fields are required.');
        }

        // Check for existing contact
        List<Contact> existingContacts = [
            SELECT Id, FirstName, LastName, Email 
            FROM Contact 
            WHERE FirstName = :firstName 
            AND LastName = :lastName 
            AND Email = :email 
            LIMIT 1
        ];

        if (!existingContacts.isEmpty()) {
            throw new AuraHandledException('Contact already exists.');
        }

        try {
            Contact con = new Contact();
            con.FirstName = firstName;
            con.LastName = lastName;
            con.Email = email;
            insert con;
            return 'Contact created successfully with Id: ' + con.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating contact: ' + e.getMessage());
        }
    }
}

UI part


<aura:component controller="CreateContactController" implements="flexipage:availableForAllPageTypes,force:appHostable">
    <aura:attribute name="firstName" type="String" />
    <aura:attribute name="lastName" type="String" />
    <aura:attribute name="email" type="String" />
    <aura:attribute name="message" type="String" />
    <aura:attribute name="isError" type="Boolean" default="false"/>

    <div class="slds-box slds-theme_default slds-p-around_medium">
        <h1 class="slds-text-heading_medium slds-p-bottom_medium">Create Contact</h1>

        <lightning:input label="First Name" value="{!v.firstName}" aura:id="firstName" required="true"/>
        <lightning:input label="Last Name" value="{!v.lastName}" aura:id="lastName" required="true"/>
        <lightning:input label="Email" type="email" value="{!v.email}" aura:id="email" required="true"/>

        <lightning:button variant="brand" label="Submit" onclick="{!c.handleSubmit}" class="slds-m-top_medium"/>

        <aura:if isTrue="{!not(empty(v.message))}">
            <div class="{!v.isError ? 'slds-text-color_error slds-p-top_medium' : 'slds-text-color_success slds-p-top_medium'}">
                <lightning:formattedText value="{!v.message}" />
            </div>
        </aura:if>
    </div>
</aura:component>

javascript 

({
    handleSubmit : function(component, event, helper) {
        // Client-side validation
        let firstName = component.get("v.firstName");
        let lastName = component.get("v.lastName");
        let email = component.get("v.email");
        let valid = true;
        let inputs = component.find(["firstName", "lastName", "email"]);

        // check required fields
        inputs.forEach(input => {
            if (!input.get("v.value")) {
                input.setCustomValidity("This field is required");
                valid = false;
            } else {
                input.setCustomValidity("");
            }
            input.reportValidity();
        });

        if (!valid) {
            component.set("v.message", "Please fill all required fields.");
            component.set("v.isError", true);
            return;
        }

        var action = component.get("c.createContact");
        action.setParams({
            firstName: firstName,
            lastName: lastName,
            email: email
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.message", response.getReturnValue());
                component.set("v.isError", false);

                // clear form
                component.set("v.firstName", "");
                component.set("v.lastName", "");
                component.set("v.email", "");
            } else {
                var errors = response.getError();
                let errorMsg = "Unknown error occurred.";
                if (errors && errors[0] && errors[0].message) {
                    errorMsg = errors[0].message;
                }
                component.set("v.message", errorMsg);
                component.set("v.isError", true);
            }
        });
        $A.enqueueAction(action);
    }
})*/
}