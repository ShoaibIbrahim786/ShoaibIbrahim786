public class AnimalsRestApiClassExample {
    
    public string getAnimalName() {
        
        Http http = new Http();
        
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        
        List<String> list_of_animals = new List<String>();
        System.debug('---res---'+res.getBody());
        if (res.getStatusCode() == 200) {
            map<string , Object> response_data = (map<string , Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('---response_data---'+response_data);
           /* for(String animals : response_data.get('animals')){

                list_of_animals.add(animals);
            }*/
        }
        System.debug('list_of_animals' +list_of_animals);
        return res.getBody();//list_of_animals;
        
    }
}