public with sharing class AccountSearchController1 {
    public AccountSearchController1(){

}
 @AuraEnabled(cacheable=true)
public static List<Account> getAccounts1(String actName1){
List<Account> accountList1 = new List<Account>();
if(actName1!=''){
    String accountName1 = '%' + actName1 + '%';
    accountList1 = [SELECT id, name from Account where name like:accountName1];
    return accountList1;

       }
   return accountList1;
   }

}