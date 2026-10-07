@IsTest
private class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2042';
    
    static testmethod void testScheduledJob() {
        List<Lead> listtoInsert = new List<Lead>();
        
        for(integer i=0; i<200; i++){
            
            Lead ld = new Lead(FirstName='John' +i, LastName='Ibrahim', Company='TCS');
            listtoInsert.add(ld);
        }
        insert listtoInsert;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> checkleads = new List<Lead>();
        checkleads =[select id from Lead where LeadSource= 'Dreamforce' and Company= 'TCS'];
        
        System.assertEquals(200, checkleads.size(),'Tasks were not created');
        
    }
}