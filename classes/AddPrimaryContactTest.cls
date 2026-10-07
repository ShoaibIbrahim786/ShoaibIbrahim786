@isTest
public class AddPrimaryContactTest {
    
     static testmethod void testQueueable() {
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState= 'NY'
            ));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i, BillingState= 'CA'
            ));
        }
        insert accounts;
        
        Contact testcontacts = new Contact(FirstName ='John', LastName = 'Ibrahim');
            insert testcontacts;
    
        
        AddPrimaryContact updater = new AddPrimaryContact(testcontacts, 'CA');
        
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        
        System.assertEquals(50, [select count() from Contact where accountId in (select id from Account where BillingState= 'CA')]);
    
     }
}