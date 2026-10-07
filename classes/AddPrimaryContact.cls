public class AddPrimaryContact implements Queueable {
    private Contact con;
    private string state;
    public AddPrimaryContact(Contact con, string state) {
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext context) {
        
        List<Account> accounts = [Select id, Name,(Select FirstName, Lastname, Id from Contacts) from Account where BillingState= :state Limit 200];
        List<Contact> Primarycontacts = new List<Contact>();
        for (Account account : accounts) {
         Contact c = con.clone();
            c.AccountId = account.id;
            Primarycontacts.add(c);
          
        }
        if (Primarycontacts.size() > 0 ){
            insert Primarycontacts;
        }
    }
}