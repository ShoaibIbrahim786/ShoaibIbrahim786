public class createEmployee {

    @AuraEnabled
    public static Account createEmployee(Account hs) {
        
        insert hs;
        return hs;
    }

}