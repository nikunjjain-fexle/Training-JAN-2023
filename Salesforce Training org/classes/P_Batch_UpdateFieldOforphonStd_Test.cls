@isTest(seeAllData=false)
public class P_Batch_UpdateFieldOforphonStd_Test {
    
    @isTest(seeAllData=false)
    public static void testP_Batch_UpdateFieldOforphonStd_Test()
    {
        List<Student__c>listOfStudentDetails=new List<Student__c>();
        Student__c  std=new Student__c();
        std.Name='nikunj';
        std.Test_TBD__c='';
        listOfStudentDetails.add(std);
        
        Student__c  std1=new Student__c();
        std1.Name='nikunj1';
        std1.Test_TBD__c='';
        listOfStudentDetails.add(std1);
        
        Student__c  std2=new Student__c();
        std2.Name='nikunj2';
        std2.Test_TBD__c='';
        listOfStudentDetails.add(std2);
        
        insert listOfStudentDetails;
        
        List<Student__c>listofstd= [SELECT Id FROM Student__c];
        System.assertEquals(3, listofstd.size());
        
        Test.startTest();
        P_Batch_UpdateFieldOforphonStd obj=new P_Batch_UpdateFieldOforphonStd('SELECT Id FROM Student__c WHERE Class__c = null AND Class__r.school__c = null');
        id batchJob=Database.executeBatch(obj);
        Test.stopTest();
        
         List<Student__c>listofstd1 = [SELECT Id, Test_TBD__c FROM Student__c WHERE Name='nikunj2'];
         System.assertEquals('Test 3', listofstd1[0].Test_TBD__c);
        
        System.assertEquals(0, P_Batch_UpdateFieldOforphonStd.emailLimits);
        
        
        
    }

}