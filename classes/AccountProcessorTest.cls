@IsTest
private class AccountProcessorTest {
  @IsTest
  private static void testContactsCount() {
    Account newAccount = new Account(Name='My Accounts');
      insert newAccount;
      
      Contact con1 = new Contact(FirstName= 'Shoaib', LastName= 'Ibrahim', AccountId = newAccount.Id);
      insert con1 ;
      
      Contact con2 = new Contact(FirstName= 'Shoai', LastName= 'Ibrahi', AccountId = newAccount.Id);
      insert con2 ;
      
      List<Id> accountsid = new List<Id>();
       accountsid.add(newAccount.Id);
      
    Test.startTest();
     AccountProcessor.countContacts(accountsid);
    Test.stopTest();
  }
}