@IsTest
public class MyIterableTest {

    @IsTest
    static void testIterableForLoop(){
        
        List<String> strings = new List<String>{'Hello','World'};
            
            MyIterable myIterableinstances = new MyIterable (Strings);
        
        System.debug('Running the for loop...');
        
        for(String str : myIterableinstances){
            
             System.debug('String: ' +str);
            
        }
        
    }
}