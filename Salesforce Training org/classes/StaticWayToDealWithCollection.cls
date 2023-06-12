/*
 * Purpose       : How to Deal static Way with Collections
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 25-03-2023
 * 
 * Version       :
*/


public without sharing  class  StaticWayToDealWithCollection {
    
    // Map
    Map<String,Map<String,List<String>>>mapListofCity;
    
    // Method
    public static Map<String,Map<String,List<String>>> cityOfStateOfCountry(){
        
        Map<String,Map<String,List<String>>>mapListofCity=new Map<String,Map<String,List<String>>>
        {
            'India'=>
                new Map<String,List<String>>
            {
                'Rajasthan'=>new List<String>{'Jaipur','Udaipur','Dungarpur'},
                    'Bihar'=>new List<String>{'Patana','Rajgiri','StriParshwanath'}
                
            },
                
           'USA'=> 
                new Map<String,List<String>>
            {
                'California'=> new List<String>{'California1','California2'},
                    'Florida'=> new List<String>{'Florida1','Florida2'}
            }
        };
            
            
        return mapListofCity;
        
        
        /*
         
        //How Access Value of NestedMap from Outer Map
        System.debug('Map of Country States City =>'+mapListofCity.get('India').get('Rajasthan'));
        
        //Direct input Map key and Values
        MapListofCity.put('Nikunj',new map<String,List<STring>>{'Jain'=> new List<String>{'jain','123'}})
            
            //How get Key of Nested Map
            // Nested KetSet of Nested_Map
            System.debug(mapListofCity.get('India').keyset());
        
        
        // All value of India Keys get
        System.debug('Map of Country States City =>'+mapListofCity.get('India').Values());
        
        
        // Only Access outer map Key
        System.debug('Map of Country States City =>'+mapListofCity.KeySet());
        
        // its Return only outer Map key's --Values
        System.debug('Map of Country States City =>'+mapListofCity.values());
        
        // Add in list
        mapListofCity.get('India').get('Rajasthan').add('Hiiii99');
        System.debug('@@@'+mapListofCity.values());  
        
        
           
          
        
        List<String> newList = new List<String>{'Jain','123'};    
            MapListofCity.get('India').put('Ritik',newList);
        System.debug('mapListofCity : '+mapListofCity);
        
        
        List<String> newListOfStudentName=new List<String>{'chayan','Ritik','Shantanu','Harsh'};
            newListOfStudentName.set(0,'******');
        
        MapListofCity.put('Ritik',new Map<String,List<String>>{'jain'=>new List<String>{'1','2','3'}});
        
        mapListofCity.get('India').put('Friendes',newListOfStudentName);
        
        mapListofCity.get('India').remove('Friendes');
        
        System.debug('###########'+MapListofCity);
        
        
        
        for(String str : mapListofCity.keySet())
        {           
            for(String s: mapListofCity.get(str).keyset() )
            {
                System.debug('======>   ' +mapListofCity.get(str).get(s));
            }
        }
        
         */
        
    }

}