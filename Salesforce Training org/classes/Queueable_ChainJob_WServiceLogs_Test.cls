/**
*
*  Purpose          :	Queueable Job Class to have the logic to update "HTTPCalloutConfiguration__mdt" custom metadata type records.
*
*  Created Date     :  	06-06-2023
*
*  Created By       :  	Nikunj jain
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
@isTest(seeAllData=false)
public class Queueable_ChainJob_WServiceLogs_Test 
{
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
        Queueable_ChainJobForCreateWServiceLogs job=new Queueable_ChainJobForCreateWServiceLogs('Queueable Method');
        Id jobId = System.enqueueJob(job);
        System.Assert(jobId!=null);
        
        
        Test.stopTest();
        
    }

}