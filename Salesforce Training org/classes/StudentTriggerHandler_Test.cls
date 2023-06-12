/*
 * Purpose      : write Test Class Of Student Trigger Handler
 * 
 * Created By   : Nikunj jain
 * 
 * Created Date : 27/03/2023
 * 
 * Revision Log : V_1.0
 * 
*/

@isTest(SeeAllData=false)
public class StudentTriggerHandler_Test {

    @testsetup static void setup()
    {
        List<School__c>listOfSchool=new List<School__c>();
        School__c sch=new School__c();
        sch.Name='JPS';
        sch.Active__c=true;
        listOfSchool.add(sch);
        
        School__c sch1=new School__c();
        sch1.Name='GPS';
        sch1.Active__c=true;
        listOfSchool.add(sch1);
        
        insert listOfSchool;
        
        List<Class__c>listOfClasses=new List<Class__c>();
        class__c cl=new Class__c();
        cl.Name='First Class';
        cl.School__c=sch.Id;
        listOfClasses.add(cl);
        
        class__c cl1=new Class__c();
        cl1.Name='Second Class';
        cl1.School__c=sch1.Id;
        listOfClasses.add(cl1);
        
        insert listOfClasses;
        
        List<Student__c>listOfStudent=new List<Student__c>();
        Student__c std=new Student__c();
        std.Name='std';
        //std.RecordTypeId='General';
        std.Class__c=cl.id;
        std.School__c=sch.Id;
        listOfStudent.add(Std);
        
        Student__c std1=new Student__c();
        std1.Name='std';
        //std1.RecordTypeId='General';
        std1.Class__c=cl1.id;
        std1.School__c=sch1.Id;
        listOfStudent.add(Std1);
        
        insert listOfStudent;
        
        
    }
    
    @isTest(SeeAllData=false)
    public static void testInsertionOfStudentTriggerHandler()
    {
        List<School__c>listOfStudent=[SELECT id,Name,No_Of_Student__c FROM School__c WHERE Name='GPS'];
        System.assertEquals(1, listOfStudent.size());
        
        Test.startTest();
        for(School__c sch:listOfStudent)
        {
            sch.No_Of_Student__c=3;
        }
        update listOfStudent;
        Test.stopTest();
        
        List<School__c>updatedListOfStudent=[SELECT id,Name,No_Of_Student__c FROM School__c WHERE Name='GPS'];
        System.debug('updatedListOfStudent-'+updatedListOfStudent);
        System.assertEquals(1, updatedListOfStudent[0].No_Of_Student__c);
        
    }
}