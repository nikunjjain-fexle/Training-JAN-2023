/*
 * Purpose       : Test Class of Queueable Job Class
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 12-04-2023
 * 
 * Version       : V_0.1
*/

@isTest(seeAllData=false)
public class Queueable_UpdateUserWithHerokuApp_Test {
    
    @testsetup static void  setup()
    {
        School__c schl = new School__c();
        schl.Name='New School';
        schl.No_Of_Teachers__c=5;
        insert schl;
        
        Class__c cl = new Class__c();
        cl.Name='New Class';
        cl.School__c=schl.Id;
        insert cl;
    }
    
    @isTest(SeeAllData=false)
    public static void testQueueable_UpdateUserWithHerokuApp()
    {
        List<User> listOfUsers=[SELECT Id, Heroku_App_Response__c FROM User
                                WHERE Id=:System.Label.INTEGERATION_USER_RECORD_ID
                                AND IsActive=true];
        System.assertEquals(1,listOfUsers.size());
        set<Id>setIds = new set<Id>();
        List<School__c> listOfSch=[Select Id,No_Of_Teachers__c from School__c WHERE Name='New School'];
        for(School__c sc :listOfSch)
        {
           setIds.add(sc.id);            
        }
        Test.startTest();
        Queueable_UpdateUserWithHerokuAppDetails job=new Queueable_UpdateUserWithHerokuAppDetails(setIds);
        Id jobId = System.enqueueJob(job);
        System.Assert(jobId!=null);
        Queueable_UpdateUserWithHerokuAppDetails job1=new Queueable_UpdateUserWithHerokuAppDetails(setIds,'Second Job');
        Id jobIds = System.enqueueJob(job1);
        System.Assert(jobIds!=null);
        
        Test.stopTest();
        
    }

}