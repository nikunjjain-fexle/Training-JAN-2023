@isTest(seeAllData=false)
public class CountsManager_Test {
    
    @Testsetup
    public static void setUp()
    {
        School__c schl=new School__c();
        schl.Name='JPS6';
        insert schl;
        
        Class__c cl=new Class__c();
        cl.Name='first class';
        cl.Board__c='CBSE';
        cl.School__c=schl.Id;
        insert cl;
        
        List<Student__c>listOdStudents=new List<Student__c>();
        Student__c std=new Student__c();
        std.Name='Nikunj';
        std.Class__c=cl.Id;
        std.School__c=schl.Id;
        listOdStudents.add(std);
        
        Student__c std1=new Student__c();
        std1.Name='Nikunj';
        std1.Class__c=cl.Id;
        std1.School__c=schl.Id;
        listOdStudents.add(std1);
        
        
        Student__c std2=new Student__c();
        std2.Name='Nikunj';
        std2.Class__c=cl.Id;
        std2.School__c=schl.Id;
        listOdStudents.add(std2);
        
        insert listOdStudents;
    }
    
    @isTest(seeAllData=false)
    private static void testNoOfStudentAndClass()
    {
        List<School__c> listofSchoolsDetails = [SELECT Id, Name, No_Of_Student__c, No_Of_Class__c FROM School__c];
        Set<id>setofSchlIds=new Set<id>();
        
        for(School__c schl:listofSchoolsDetails)
        {
            setofSchlIds.add(schl.id);
        }
        
        System.assertEquals(1, listofSchoolsDetails.size());
        
        Test.startTest();
        CountManagerOld.updateNoOfStudentsDetails(listofSchoolsDetails[0].Name);
        for(Id idss : setofSchlIds)
        {
            CountManagerOld.updateNoOfClassesDetails(idss);
        }
        Test.stopTest();
        List<School__c> listofSchoolsDetails1 = [SELECT Id, Name, No_Of_Student__c, No_Of_Class__c FROM School__c];
        System.debug(listofSchoolsDetails);
        System.assertEquals(3,listofSchoolsDetails1[0].No_Of_Student__c);
        System.assertEquals(1,listofSchoolsDetails1[0].No_Of_Class__c);
    }
}