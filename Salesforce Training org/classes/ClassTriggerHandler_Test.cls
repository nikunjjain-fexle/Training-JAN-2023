/**
 * Purpose       : Test Class Of ClassTriggerHandler
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Version       : V_01
 * 
**/

@isTest(seeAllData = false)
public class ClassTriggerHandler_Test {

    
    @testSetup static void setup()
    {
        Account acc=new Account();
        acc.Name='Account';
        insert acc;
        
        Contact con1=new Contact();
        con1.LastName='con1';
        con1.AccountId=acc.Id;
        con1.Paid_Amount__c=100;
        insert con1;
        
        Contact con2=new Contact();
        con2.LastName='con2';
        con2.AccountId=acc.Id;
        con2.Paid_Amount__c=200;
        insert con2;
        
        Contact con3=new Contact();
        con3.LastName='con3';
        con3.AccountId=acc.Id;
        con3.Paid_Amount__c=300;
        insert con3;
        
    }
    @isTest(seeAllData = false)
    private static void testSequenceNumberOfContact()
    {
        List<Account>accList=[SELECT ID, Name FROM Account];
        List<Contact>conList=[SELECT AccountId ,Paid_Amount__c,Sequence_Number__c FROM Contact WHERE AccountId =:accList];
        System.assertEquals(3, conList.size());
        
        Test.startTest();
        List<Contact>updateconList=new List<Contact>();
        Contact con4=new Contact();
        con4.LastName='con4';
        con4.AccountId=accList[0].ID;
        con4.Paid_Amount__c=150;
        updateconList.add(con4);
        insert updateconList;
        
        List<Contact>deleteConList=[SELECT Id,Name FROM Contact WHERE Name='con1'];
        delete deleteConList;
        
        
        
        
        Test.stopTest();
        
        List<Contact>finallUpdateConList=[SELECT Name,AccountId ,Paid_Amount__c,Sequence_Number__c FROM Contact WHERE AccountId =:accList AND Name='con4'];
        System.assertEquals(1, finallUpdateConList[0].Sequence_Number__c);
    }
    
    
    //@testSetup static void setup()
    {
        List<Class__c> classes = new List<Class__c>();
        List<School__c> schools = new List<School__c>();
        List<Student__c> students = new List<Student__c>();
        
        School__c sch1 = new School__c();
        sch1.Name = 'New School';
        schools.add(sch1);
        
        School__c sch2 = new School__c();
        sch2.Name = 'Old School';
        schools.add(sch2);
        
        insert schools;
        
        Class__c cl1 = new Class__c();
        cl1.Name = 'Class 1';
        cl1.School__c = sch1.Id;
        cl1.Board__c = 'CBSE';
        classes.add(cl1);
        
        Class__c cl2 = new Class__c();
        cl2.Name = 'Class 2';
        cl2.School__c = sch2.Id;
        cl2.Board__c = 'CBSE';
        classes.add(cl2);
        
        insert classes;
        
        Student__c std1 = new Student__c();
        std1.Name = 'Student One';
        std1.Class__c = cl1.Id;
        students.add(std1);
        
        Student__c std2 = new Student__c();
        std2.Name = 'Student Two';
        std2.Class__c = cl1.Id;
        students.add(std2);
        
        Student__c std3 = new Student__c();
        std3.Name = 'Student Three';
        std3.Class__c = cl2.Id;
        students.add(std3);
        
        insert students;
    }
    
    //@isTest(seeAllData = false)
    private static void testCountNoOfClassesTest()
    {
        List<School__c> schools = [SELECT Id FROM School__c WHERE No_of_Class__c = 1 ];
        
        System.assertEquals(2, schools.size());
        
        Test.startTest();
        
        Class__c newClass = new Class__c(Name = 'New Class', School__c = schools[0].Id, Board__c = 'CBSE');
        insert newClass;
        
        Test.stopTest();
        
        List<School__c> sch = [SELECT Id FROM School__c WHERE No_of_Class__c = 1];
        System.assertEquals(1, sch.size());
        
        
    }
    
    
}