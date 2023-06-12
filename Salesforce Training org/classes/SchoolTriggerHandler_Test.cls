/*
 * Purpose       : Test Class Of Find No Of Student And no Of Classes On School Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 27-03-2023
 * 
 * Revison Log   : V_1.0 27-03-2023
 *                 V_1.1 Modified By Nikunj jain 11-04-2023
 */



@isTest(SeeAllData=false)
public class SchoolTriggerHandler_Test {
    @testsetup static void setup()
    {
        School__c sch=new School__c();
        sch.Name='Old School';
        sch.No_Of_Teachers__c=5;
        insert sch;
        
        class__c cl=new Class__c();
        cl.Name='first class';
        cl.School__c=sch.id;
        insert cl;
    }
    
    @isTest(SeeAllData=false)
    private static void testDoApexSharingCalculations()
    {    
        List<User> listOfUsers=[SELECT Id, Heroku_App_Response__c FROM User
                                WHERE Id=:System.Label.INTEGERATION_USER_RECORD_ID
                                AND IsActive=true];
        System.assertEquals(1,listOfUsers.size());
        
        
        
        School__c sch=[Select Id,No_Of_Teachers__c from School__c WHERE Name='Old School'];
        sch.No_Of_Teachers__c=25;
        update sch;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        listOfUsers=[SELECT Id, Heroku_App_Response__c FROM User
                     WHERE Id=:System.Label.INTEGERATION_USER_RECORD_ID
                     AND IsActive=true];
        Set<Id> setOfSchoolIds=new Set<Id>();
        setOfSchoolIds.add(sch.Id);
        System.Assert(listOfUsers[0].Heroku_App_Response__c!=null);
        
        
        
        /*
System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

List<School__c> listOfschool = [SELECT id, No_Of_Teachers__c FROM School__c WHERE Name='test 1'];
listOfschool[0].No_Of_Teachers__c = 20;
update listOfschool;



List<User> listOfApexSharingUser = [SELECT Id FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
System.assertEquals(1,listOfApexSharingUser.size());*/
        
        
        
        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        //listOfApexSharingUser = [SELECT Id, H__c FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
        //System.debug('listOfApexSharingUser -----'+listOfApexSharingUser);
        
        //System.assertEquals(1, listOfApexSharingUser.size());
        
    }
    
    
    
    
    
    /*  

//@testsetup static void setup()
{
List<School__c> listOfschool=new List<School__c>();

List<Class__c> listOfClasss=new List<Class__c>();

List<Student__c>student=new List<Student__c>();

School__c sch1=new School__c();
sch1.Name='JPS1';
listOfschool.add(sch1);

School__c sch2=new School__c();
sch2.Name='JPS2';
listOfschool.add(sch2);

insert listOfschool;

Class__c cl1=new Class__c();
cl1.Name='Class first';
cl1.School__c=sch1.id;
listOfClasss.add(cl1);

Class__c cl2=new Class__c();
cl2.Name='Class second';
cl2.School__c=sch1.id;
listOfClasss.add(cl2);  

Class__c cl3=new Class__c();
cl3.Name='Class third';
cl3.School__c=sch2.id;
listOfClasss.add(cl3);

insert listOfClasss;

Student__c std=new Student__c();
std.name='Shantanu1';
std.Class__c=cl1.id;
std.School__c=sch1.id;
student.add(std);

Student__c std1=new Student__c();
std1.name='Shantanu2';
std1.Class__c=cl2.id;
std1.School__c=sch1.id;
student.add(std1);

Student__c std2=new Student__c();
std2.name='Shantanu3';
std2.Class__c=cl3.id;
std2.School__c=sch2.id;
student.add(std2);

insert student; 



}
//@isTest(SeeAllData=false)
public static void testCountNoOfStudentTest()
{
List<School__c>schl=[SELECT id , No_Of_Student__c FROM School__c WHERE No_Of_Student__c=2];

System.assertEquals(1, schl.size());

//List<Class__c> cl =[SELECT id, Name FROM Class__c WHERE Name='Class third'];

Test.startTest();

Student__c std1=new Student__c(Name='s11',School__c = schl[0].id);
insert std1;

Test.stopTest();

List<School__c> updateSchl = [SELECT id FROM School__c WHERE No_Of_Student__c = 3];
System.assertEquals(1, updateSchl.size()); 

}*/
    
}