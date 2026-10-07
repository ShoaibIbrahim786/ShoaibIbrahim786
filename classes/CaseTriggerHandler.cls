public with sharing class CaseTriggerHandler {
    
     // Method to check if trigger is active via Custom Metadata
    public static Boolean isTriggerActive(String triggerName) {
        Trigger_Switch__mdt config = [
            SELECT IsActive__c 
            FROM Trigger_Switch__mdt 
            WHERE DeveloperName = :triggerName 
            LIMIT 1
        ];
        return config != null && config.IsActive__c;
    }

    // Before Insert Logic
    public static void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            if (c.Priority == 'High') {
                c.Escalation_Flag__c = true;
            }
        }
    }

    // Before Update Logic
    public static void beforeUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        for (Case c : newCases) {
            Case oldCase = oldMap.get(c.Id);
            // Auto-set flag if Priority changed to High
            if (c.Priority == 'High' && oldCase.Priority != 'High') {
                c.Escalation_Flag__c = true;
            }
        }
    }

    // After Update Logic
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

    
    
    
    
    
    
    
    
    
   /* private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    
    public CaseTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }
            

    public void OnBeforeInsert(List<Case> newCase)
    {
       /*{
            if(!newCase.isEmpty())
            {
                for(Case case1 : newCase)
                {
                    if(case1.SuppliedPhone == null || case1.SuppliedPhone == '')
                    {
                        case1.addError('You cannot insert case with phone field empty');
                    }
                }
            }
       }
        system.debug('Case Trigger On Before Insert');
    }
    public void OnAfterInsert(List<Case> newCase)
    {
        system.debug('Case Trigger On After Insert');
    }
    public void OnAfterUpdate( List<Case> newCase, List<Case> oldCase, Map<ID, Case> newCaseMap , Map<ID, Case> oldCaseMap )
    {
       // @Description Automated Updating the Account Desc once the Case Desc is updating.
        Set<Id> parentAccIds = new Set<Id>();
        if (!newCase.isEmpty()) {
            for (Case caseObj : newCase) {
            if (caseObj.AccountId != null && caseObj.Description != oldCaseMap.get(caseObj.Id).Description) {
            parentAccIds.add(caseObj.AccountId);
            }
          }
        }
        
        if (!parentAccIds.isEmpty()) {
            Map<Id, Account> mapToUpdate = new Map<Id, Account>();
            Map<Id, Account> parentAccMap = new Map<Id, Account>([SELECT Id, Description FROM Account WHERE Id IN :parentAccIds]);
            if (!newCase.isEmpty()) {
            for (Case cas : newCase) {
            if (parentAccMap.containsKey(cas.AccountId)) {
            Account acc = parentAccMap.get(cas.AccountId);
            acc.Description = cas.Description;
            mapToUpdate.put(acc.Id, acc);
            }
            }
            }
            if (!mapToUpdate.isEmpty()) {
            try {
            update mapToUpdate.values();
            } catch (Exception ex) {
            System.debug('Error while updating record-->' + ex.getMessage());
            }
            }
            }
        system.debug('Case Trigger On After Update ');
        CaseActions.updateContact (newCase);
    }
    public void OnBeforeUpdate( List<Case> newCase, List<Case> oldCase, Map<ID, Case> newCaseMap , Map<ID, Case> oldCaseMap )
    {
        system.debug('Case Trigger On Before Update ');
    }

    @future 
    public static void OnAfterUpdateAsync(Set<ID> newCaseIDs)
    {

    }      
    public boolean IsTriggerContext
    {
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext
    {
        get{ return !IsTriggerContext;}
    }*/

}