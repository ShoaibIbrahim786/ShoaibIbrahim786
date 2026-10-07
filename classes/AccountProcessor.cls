public class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountsIds) {
      
      List<Account> accountsToUpdate = new  List<Account>();
      
    List<Account> accounts = [Select Id, Name,(Select id from Contacts) from Account Where Id IN :accountsIds];
    // process account records to do awesome stuff
      for (Account acc: accounts){
          List<Contact> ContactList = acc.Contacts;
          acc.Number_Of_Contacts__c = ContactList.size();
          accountsToUpdate.add(acc);
      }
      update accountsToUpdate;
  }

}