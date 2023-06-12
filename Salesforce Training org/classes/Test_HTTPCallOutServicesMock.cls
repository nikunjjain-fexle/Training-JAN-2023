@istest(seeAllData=false)
public class Test_HTTPCallOutServicesMock {
    @testsetup static void listOfSchoolsCreation()
   {
       List<School__c> listOfSchools=new List<School__c>();
        School__c sch1=new School__c(Name='Test Rajdeep School 1',Active__c=true,About_US__c='This is the test School created on 12-04-23',No_Of_Teachers__c=21);
        listOfSchools.add(sch1);
        
        School__c sch2=new School__c(Name='Test Rajdeep School 2',Active__c=true,About_US__c='This is the test School created on 12-04-23',No_Of_Teachers__c=15);
        listOfSchools.add(sch2);
        
        School__c sch3=new School__c(Name='Test Rajdeep School 3',Active__c=true,About_US__c='This is the test School created on 12-04-23',No_Of_Teachers__c=13);
        listOfSchools.add(sch3);
        
        insert listOfSchools;
   }
    /*
     Testing with predefined custom metadata record
    */
    
    @isTest(seeAllData=false)
    public static void testWithCustomMetadata() 
    {
        /*List<User> listOfUsers=[SELECT Id FROM User
                                        WHERE Id=:System.Label.INTEGRATION_USER_RECORD_ID
                                        AND IsActive=true];
        System.assertEquals(1,listOfUsers.size());
        Set<Id> schIds=new Set<Id>();
        School__c sch=[Select Id,No_Of_Teachers__c from School__c WHERE Name='Test Rajdeep School 2'];
        sch.No_Of_Teachers__c=25;
        update sch;*/
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
       // update sch;
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = CalloutClassDemo.getInfoFromExternalService();
        
        // Verify response received contains fake values
        String actualValue = res.getBody();
        String expectedValue = '{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
/*       listOfUsers=[SELECT Id,Heroku_App_Response__c FROM User
                     WHERE Id=:System.Label.INTEGRATION_USER_RECORD_ID
                      AND IsActive=true];
        Set<Id> setOfSchoolIds=new Set<Id>();
        setOfSchoolIds.add(sch.Id);
        System.Assert(listOfUsers[0].Heroku_App_Response__c!=null);
        System.debug(listOfUsers[0].Heroku_App_Response__c);*/

        //System.assertEquals(listOfUsers[0].Heroku_App_Response__c,HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(setOfSchoolIds));
        //System.debug('@@@@@ Response from Test_HTTPCallOutServicesMock: '+ res);
    }

}