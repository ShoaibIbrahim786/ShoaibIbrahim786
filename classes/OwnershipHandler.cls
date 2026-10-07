public class OwnershipHandler {
    public static void handleOwnershipChange(List<SObject> records, String objectName) {
        Set<String> agencySet = new Set<String>();
        Map<String, Id> agencyToNewOwnerMap = new Map<String, Id>();
        
        //Schema map to check field existence dynamically
         Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();

        // Collect agencies where ownership has changed
        for (SObject record : records) {
            if (fieldMap.containsKey('Agency__c') && fieldMap.containsKey('OwnerId')) {
                String agency = (String) record.get('Agency__c');
                Id newOwner = (Id) record.get('OwnerId');
                
                if (agency != null && agency.contains('1234')) {
                    agencySet.add(agency);
                    agencyToNewOwnerMap.put(agency, newOwner);
                }
            }
        }

        if (!agencySet.isEmpty()) {
            updateOwnershipAcrossObjects(agencySet, agencyToNewOwnerMap);
        }
    }

    private static void updateOwnershipAcrossObjects(Set<String> agencies, Map<String, Id> agencyToNewOwnerMap) {
        List<SObject> allRecordsToUpdate = new List<SObject>();

        // Query all objects related to the affected agencies
        List<Account> accounts = [SELECT Id, OwnerId, Agency__c FROM Account WHERE Agency__c IN :agencies];
        List<Contact> contacts = [SELECT Id, OwnerId, Agency__c FROM Contact WHERE Agency__c IN :agencies];
        //List<Group_Number__c> groups = [SELECT Id, OwnerId, Agency__c FROM Group_Number__c WHERE Agency__c IN :agencies];
        //List<Policy__c> policies = [SELECT Id, OwnerId, Agency__c FROM Policy__c WHERE Agency__c IN :agencies];

        // Update ownership for each object type
        for (Account acc : accounts) {
            acc.OwnerId = agencyToNewOwnerMap.get(acc.Agency__c);
            allRecordsToUpdate.add(acc);
        }
        for (Contact con : contacts) {
            con.OwnerId = agencyToNewOwnerMap.get(con.Agency__c);
            allRecordsToUpdate.add(con);
        }
       /* for (Group_Number__c grp : groups) {
            grp.OwnerId = agencyToNewOwnerMap.get(grp.Agency__c);
            allRecordsToUpdate.add(grp);
        }
        for (Policy__c pol : policies) {
            pol.OwnerId = agencyToNewOwnerMap.get(pol.Agency__c);
            allRecordsToUpdate.add(pol);
        }*/

        // Update all records in a single DML statement
        if (!allRecordsToUpdate.isEmpty()) {
            update allRecordsToUpdate;
        }
    }
}