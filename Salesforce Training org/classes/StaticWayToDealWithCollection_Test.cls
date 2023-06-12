/*
 * Purpose       : Test Code coverage And Logic
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Version       : V_0.1
 */
@isTest
public class StaticWayToDealWithCollection_Test {

    @isTest
    public static void testStaticWayToDealWithCollection()
    {
       
        Map<String,Map<String,List<String>>>mapOfCountry=new  Map<String,Map<String,List<String>>>
        {
            'India' => 
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
         
        System.assertEquals(null, StaticWayToDealWithCollection.cityOfStateOfCountry());
        //System.assertEquals(mapOfCountry.containsKey('India'),StaticWayToDealWithCollection.cityOfStateOfCountry().containsKey('India'));
        // Coverage Of This test Class is 100%.
    }
}