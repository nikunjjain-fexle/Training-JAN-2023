/**
 * Purpose     : Test class of Practice Assessment Questions
 * 
 * Created By  : Nikunj jain
 * 
 * Create Date : 20-03-2023
 * 
 * Resion Log  :
 *
*/
@isTest(seeAllData=false)
public class AssessmentClassHandler_Test {
    @testsetup static void setup()
    {
        School__c sch=new School__c();
        sch.Name='New School';
        insert sch;
        
        Class__c cl=new Class__c();
        cl.Name='First Class';
        cl.School__c=sch.id;
        insert cl;
        
        Class__c cl1=new Class__c();
        cl1.Name='Second Class';
        cl1.School__c=sch.id;
        insert cl1;
        
        Student__c std=new Student__c();
        std.Name='Std';
        std.School__c=sch.id;
        std.Class__c=cl.Id;
        insert std;
        
        Student__c std1=new Student__c();
        std1.Name='Std';
        std1.School__c=sch.id;
        std1.Class__c=cl.Id;
        insert std1;
        
        
        Student__c std2=new Student__c();
        std2.Name='Std';
        std2.School__c=sch.id;
        std2.Class__c=cl.Id;
        insert std2;
        
        
    }
    @isTest(seeAllData=false)
    public static void testupdationOfClass()
    {
        List<School__c>listOfSchool=[SELECT Id, No_Of_Student__c FROM School__c];
        List<Class__c>listOfClass=[SELECT Id FROM Class__c WHERE Name =:'Second Class'];
        System.assertEquals(1, listOfSchool.size());
        
        Test.startTest();
        
        Class__c cl3=new Class__c();
        cl3.Name='ji';
        cl3.School__c=listOfSchool[0].id;
        
        insert cl3;
       
        Test.stopTest();
        List<School__c>updateListOfSchool=[SELECT Id, No_Of_Student__c,No_Of_Class__c FROM School__c];
        System.assertEquals(3, updateListOfSchool[0].No_Of_Student__c);
        System.assertEquals(3, updateListOfSchool[0].No_Of_Class__c);
    }

}