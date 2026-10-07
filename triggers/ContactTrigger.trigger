trigger ContactTrigger on Contact (after update) {
    
     /*OwnershipHandler.handleOwnershipChange(Trigger.new, 'Contact');*/
    
  /*
   * public with sharing class DuplicateContactsController {
    
    @AuraEnabled
    public static List<List<Contact>> findDuplicateContacts() {
        // First get the ID of your specific duplicate rule
        String duplicateRuleId = [SELECT Id FROM DuplicateRule WHERE DeveloperName = 'Primary_Contact_Duplicate_Rule' LIMIT 1].Id;
        
        List<Contact> contactsToCheck = [
            SELECT Id, Name, Email, Phone, Account.Name,
                   MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry,
                   Company__c, District__c, Agency__c
            FROM Contact
            WHERE Is_Primary__c = TRUE
            ORDER BY Name
        ];
        
        // Create request with specific duplicate rule
        Datacloud.FindDuplicatesRequest request = new Datacloud.FindDuplicatesRequest();
        request.duplicateRuleId = duplicateRuleId;
        request.records = contactsToCheck;
        request.includeRecordDetails = true;
        
        // Execute the request
        Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(
            new List<Datacloud.FindDuplicatesRequest>{request}
        );
        
        // Process results as before
        List<List<Contact>> duplicateGroups = new List<List<Contact>>();
        for (Datacloud.FindDuplicatesResult findDupeResult : results) {
            for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                if (dupeResult.success) {
                    for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                        if (matchResult.size() > 1) {
                            List<Contact> duplicateGroup = new List<Contact>();
                            for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                                duplicateGroup.add((Contact)matchRecord.getRecord());
                            }
                            duplicateGroups.add(duplicateGroup);
                        }
                    }
                }
            }
        }
        
        return duplicateGroups;
    }
}

Helper.js
-----------------
({
    getDuplicateContacts: function(component) {
        component.set('v.isLoading', true);
        
        var action = component.get('c.findDuplicateContacts');
        action.setCallback(this, function(response) {
            component.set('v.isLoading', false);
            var state = response.getState();
            
            if (state === 'SUCCESS') {
                var result = response.getReturnValue();
                
                // Process the data for display
                var duplicates = [];
                var groupNumber = 1;
                
                result.forEach(function(group) {
                    group.forEach(function(contact) {
                        // Format the contact for display
                        var displayContact = {
                            Id: contact.Id,
                            Name: '/' + contact.Id,
                            AccountName: contact.Account ? contact.Account.Name : '',
                            Email: contact.Email,
                            Phone: contact.Phone,
                            MailingAddress: this.formatAddress(contact),
                            Company__c: contact.Company__c,
                            District__c: contact.District__c,
                            Agency__c: contact.Agency__c,
                            duplicateGroup: 'Group ' + groupNumber
                        };
                        duplicates.push(displayContact);
                    });
                    groupNumber++;
                });
                
                component.set('v.duplicates', duplicates);
            } else if (state === 'ERROR') {
                var errors = response.getError();
                var errorMessage = 'Unknown error';
                if (errors && errors[0] && errors[0].message) {
                    errorMessage = errors[0].message;
                }
                component.set('v.errorMessage', errorMessage);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    formatAddress: function(contact) {
        var address = '';
        if (contact.MailingStreet) address += contact.MailingStreet + ', ';
        if (contact.MailingCity) address += contact.MailingCity + ', ';
        if (contact.MailingState) address += contact.MailingState + ' ';
        if (contact.MailingPostalCode) address += contact.MailingPostalCode + ', ';
        if (contact.MailingCountry) address += contact.MailingCountry;
        
        // Remove trailing comma if present
        if (address.endsWith(', ')) {
            address = address.substring(0, address.length - 2);
        }
        
        return address;
    },
    
    navigateToRecord: function(component, recordId) {
        var navEvent = $A.get('e.force:navigateToSObject');
        navEvent.setParams({
            'recordId': recordId,
            'slideDevName': 'detail'
        });
        navEvent.fire();
    }
})

Aura Controller Js
--------------------------
({
    doInit: function(component, event, helper) {
        // Define columns for the data table
        component.set('v.columns', [
            {label: 'Contact Name', fieldName: 'Name', type: 'url',
             typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Account', fieldName: 'AccountName', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'email'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Address', fieldName: 'MailingAddress', type: 'text'},
            {label: 'Company', fieldName: 'Company__c', type: 'text'},
            {label: 'District', fieldName: 'District__c', type: 'text'},
            {label: 'Agency', fieldName: 'Agency__c', type: 'text'},
            {label: 'Duplicate Group', fieldName: 'duplicateGroup', type: 'text'},
            {
                type: 'action',
                typeAttributes: {
                    rowActions: [
                        { label: 'View', name: 'view' },
                        { label: 'Merge', name: 'merge' }
                    ]
                }
            }
        ]);

        // Call server to get duplicate records
        helper.getDuplicateContacts(component);
    },

    handleRowAction: function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        
        switch (action.name) {
            case 'view':
                helper.navigateToRecord(component, row.Id);
                break;
            case 'merge':
                // You would implement merge functionality here
                // This would typically open a modal or navigate to the standard merge page
                alert('Merge functionality would be implemented here for: ' + row.Name);
                break;
        }
    }
})

Aura componenet
--------------------------
<aura:component controller="DuplicateContactsController" implements="flexipage:availableForAllPageTypes,force:hasRecordId" access="global">
    <aura:attribute name="recordId" type="Id" />
    <aura:attribute name="duplicates" type="List" />
    <aura:attribute name="columns" type="List" />
    <aura:attribute name="isLoading" type="Boolean" default="true" />
    <aura:attribute name="errorMessage" type="String" />

    <!-- Handler for initialization -->
    <aura:handler name="init" value="{!this}" action="{!c.doInit}" />

    <!-- Display loading spinner -->
    <aura:if isTrue="{!v.isLoading}">
        <lightning:spinner variant="brand" size="large" />
    </aura:if>

    <!-- Display error message if any -->
    <aura:if isTrue="{!not(empty(v.errorMessage))}">
        <lightning:card title="Error">
            <div class="slds-p-around_medium">
                <lightning:icon iconName="utility:error" size="small" alternativeText="Error" class="slds-m-right_x-small" />
                <span class="slds-text-color_error">{!v.errorMessage}</span>
            </div>
        </lightning:card>
    </aura:if>

    <!-- Display duplicates table -->
    <aura:if isTrue="{!and(not(v.isLoading), empty(v.errorMessage), not(empty(v.duplicates))}">
        <lightning:card title="Duplicate Primary Contacts" iconName="standard:contact">
            <div class="slds-p-around_medium">
                <lightning:datatable
                    keyField="id"
                    data="{!v.duplicates}"
                    columns="{!v.columns}"
                    hideCheckboxColumn="true"
                    onrowaction="{!c.handleRowAction}"
                />
            </div>
        </lightning:card>
    </aura:if>

    <!-- Display message if no duplicates found -->
    <aura:if isTrue="{!and(not(v.isLoad
*/


}