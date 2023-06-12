/*
 * Purpose       : Write Test Class Of DyanmicWayDealWithCollectrion
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Revision Log  : V_0.1  92%
 * 
 */

@isTest(SeeAllData=false)
public class DyanmicWayToDealWithCollection_Test {
    
    @testsetup Static void setup()
    {
        School__c schl=new School__c();
        schl.Name='PSL';
        insert schl;
        
       
        
       
        
        Class__c cl=new Class__c();
        cl.Name='First Class';
        cl.School__c=schl.Id;
        insert cl;
        
        Class__c cl2=new Class__c();
        cl2.Name='Second Class';
        cl2.School__c=schl.Id;
        insert cl2;
        
        List<Student__c>listOfStudent=new List<Student__c>();
        Student__c std=new Student__c();
        std.Name='nj';
        std.Class__c=cl.Id;
        std.School__c=schl.id;
        insert std;
        
        
        Student__c std1=new Student__c();
        std1.Name='nj1';
        std1.Class__c=cl.Id;
        std1.School__c=schl.id;
        insert std1;
        
        
        Student__c std2=new Student__c();
        std2.Name='nj2';
        std2.Class__c=cl2.Id;
        std2.School__c=schl.id;
        insert std2;
        
        
    }
    
    @isTest(SeeAllData=false)
    public static void testDyanmicWayToDealWithCollection()
    {
        List<School__c>listOfSchool=[SELECT Id, Name, No_Of_Student__c FROM School__c ];
        System.assertEquals(1, listOfSchool.size());
        
        System.debug('####'+listOfSchool);
        Test.startTest();
        DyanmicWayToDealWithCollections obj=new DyanmicWayToDealWithCollections();
        
        Test.stopTest();
        
        List<School__c>updateListOfSchool=[SELECT Id, Name, No_Of_Class__c FROM School__c];
        System.debug('####'+updateListOfSchool);
        System.assertEquals('PSL', updateListOfSchool[0].Name);
        
    }
}