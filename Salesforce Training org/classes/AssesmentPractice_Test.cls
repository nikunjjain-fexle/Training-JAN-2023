/**
*
*  Purpose          :  Apex Test Class Assessment Practice.
*
*  Created Date     :   
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
@isTest(seeAlldata=false)
public class AssesmentPractice_Test {
    
    @testsetup static void setup()
    {
        School__c sc=new School__c();
        sc.Name='sc1';
        sc.No_Of_Teachers__c=5;
        
        insert sc;
    }
    
    @isTest(seeAlldata=false)
    public static void testHerokuApp()
    {
        List<School__c> listOfSchool=[SELECT ID, No_Of_Teachers__c FROM School__c];
        System.assertEquals(1, listOfSchool.size());
        Test.setMock(HTTPCalloutMock.Class, new MockOfAssessmentherokuApp());
        
        List<User> listOfUser= [SELECT Id, Heroku_App_Response__c From User WHERE Id =: System.Label.TEARCHER_USER_RECORD_ID];
        System.assertEquals(null,listOfUser[0].Heroku_App_Response__c);
        
        Test.startTest();
        listOfSchool[0].No_Of_Teachers__c=15;
        update listOfSchool;
        Test.stopTest();
        
        List<User> finalListOfUser= [SELECT Id, Heroku_App_Response__c From User WHERE Id =: System.Label.TEARCHER_USER_RECORD_ID]; 
        System.assert(finalListOfUser[0].Heroku_App_Response__c!= null);
        
        //chicken  scary bear  fluffy bunny  majestic badgerō
        
    }

}