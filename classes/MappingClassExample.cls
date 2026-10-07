public class MappingClassExample {
    
    public  Map<String,List<String>> MappingClassExp(){
        
         Map<String,List<String>> strMap = new  Map<String,List<String>>();
        List<String> strDate = new List<String>();
        List<String> strSub = new List<String>();
        
       List<Case> caselist = [Select id ,ClosedDate, Subject from Case];
        for(Case case1: caselist){
            
        
                 strSub.add(case1.Subject);
                system.debug('strSub' +strSub);
                 String Closeddate = string.valueOf(case1.ClosedDate);
                 strDate.add(Closeddate);
                 system.debug('strDate' +strDate);
            
           // String CD =  Closeddate.format('YYYY-DD-MM');
            //system.debug('CD', CD);
           
            
            
            //Date Newclosedate = Date.parse(Closeddate);
            
           
        }
        
        strMap.put('ClosedDate', strDate);
        strMap.put('Subject', strSub);
        system.debug('strMap' +strMap); 
         return strMap;
        
        
    } 
       
    Public List<Date> DateFormat(List<String> strDate){
        List<Date> d1 = new List<Date>();
        
        for(String str1: strDate){
        DateTime dT = DateTime.valueOf(str1); 
            system.debug('ComingDateValue' +str1);
            Date d = Date.newInstance(dT.year(), dT.month(), dT.day());
            system.debug('Newclosedate' +d);
          d1.add(d);  
       
    }
         return d1;
    }

}