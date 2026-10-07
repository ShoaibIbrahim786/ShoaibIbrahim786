public with sharing class AccountSearchController {

public AccountSearchController(){

}
@AuraEnabled(cacheable=true)
public static List<Account> getAccounts(String actName){
List<Account> accountList = new List<Account>();
if(actName!=''){
    String accountName = '%' + actName + '%';
    accountList = [SELECT id, name from Account where name like:accountName];
    return accountList;

       }
   return accountList;
   }

  
}