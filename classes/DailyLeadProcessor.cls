global class DailyLeadProcessor implements Schedulable{
     global void execute(SchedulableContext ctx) {
         List<Lead> leadtoupdate = new List<Lead>();
         
        List<Lead> leads = [SELECT Id from Lead where LeadSource = Null Limit 200];
         for(Lead l: leads){
             l.LeadSource = 'Dreamforce';
             leadtoupdate.add(l);
         }
        update leadtoupdate;
    }

}