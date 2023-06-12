/*
 * Purpose       : Write Test Class Of Batch Class Update Field Of Orphone Student 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023 
 * 
 */ 


@isTest(SeeALLData=false)
public class Batch_updateOrphanStudent_Test {
    
    @testsetup static void setup()
    {
         List<Student__c>Students=TestDataFactory.createListOfStudentsTestData();
    }

    @isTest(SeeALLData=false)
    public static void checkOrphanStudent()
    {
        List<Student__c>listofStd=[SELECT Id, Name FROM Student__c  ];
        
        System.assertEquals(5,listofStd.size());
        
        for(Student__c std: listofStd)
        {
            std.class__c =null;
            std.school__c =null;
        }
        
        Utilities.BypassAllTriggers=true;
        update listofStd;
        Utilities.BypassAllTriggers=false;
        
        Test.startTest();
        Batch_UpdateOrphanStudent batchOforphanStd= new Batch_UpdateOrphanStudent('SELECT id, Name FROM Student__c WHERE Class__c =null AND School__c =null AND Class__r.school__c=null');
        Database.executeBatch(batchOforphanStd, 100);
        Test.stopTest();
        System.assertEquals(5,[SELECT Count() FROM Student__c WHERE Class__c=null AND School__c =null]);
        System.assertEquals(5, listofStd.size());
        System.assertEquals(1,Batch_UpdateOrphanStudent.emailLimits);
    }
}