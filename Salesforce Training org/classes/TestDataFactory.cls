/**
*
*  Purpose          :	Factory class to create test data for testing prospective.
*
*  Created Date     :  	10/14/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
@isTest(seeAllData=false)
public without sharing class TestDataFactory 
{
    
    //Method to create the test data for Opportunity object------------------>
    public static List<Contact> creationOfContactTestData()
    {
        List<Contact>Contacts=(List<Contact>)SmartFactory.createSObjectList('Contact', false, 200);
        Utilities.BypassAllTriggers = true;
        insert Contacts;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(200, Contacts.size());
        integer i=1;
        for(Contact con : Contacts)
        {
            if(i<=100)
            {
                con.Contact_Type__c='Active';
            }
            else
            {
                con.Contact_Type__c='In Active';
            }
            i++;
        }
        if(Contacts != null)
        {
            Utilities.BypassAllTriggers=true;
            update Contacts;
            Utilities.BypassAllTriggers=false;
        }
        
        return Contacts;
    }
    
    

    //Method to create the test data for Opportunity object------------------>
    public static List<Opportunity> creationOfOpportunityTestData()
    {
        List<opportunity>Opportunities=(List<Opportunity>)SmartFactory.createSObjectList('Opportunity', false, 6);
        Utilities.BypassAllTriggers = true;
        insert Opportunities;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(6, Opportunities.size());
        return Opportunities;
    }
    
    
    
    //Method to create the test data for Bypass_Logic__c custom setting object
    @IsTest(seeAllData=false)
    public static List<Bypass_Logic__c> createBypassLogicRecords()
    {
        List<Bypass_Logic__c> listOfBypassLogics = new List<Bypass_Logic__c>();
        Bypass_Logic__c setting = Bypass_Logic__c.getOrgDefaults();
        setting.Bypass_Flows__c = false;
        setting.Objects_to_Bypass__c = Constants.CHAR_BLANK;
        listOfBypassLogics.add(setting);
        insert listOfBypassLogics;
        return listOfBypassLogics;
    }    
    
    //Method to create the test data for Account object
    @IsTest(seeAllData=false)
    public static List<Account> createListOfAccountsTestData()
    {
        List<Account> accounts = (List<Account>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_ACCOUNT, false, 5);
        Utilities.BypassAllTriggers = true;
        insert accounts;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(5, accounts.size());
        return accounts;
    }
    
    //Method to create the test data for School object
    @IsTest(seeAllData=false)
    public static List<School__c> createListOfSchoolsTestData()
    {
        List<School__c> schools = (List<School__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_SCHOOL, false, 5);
        for(School__c sc : schools) 
        {
            sc.Active__c = true;
            sc.About_US__c = Constants.CHAR_TEST;
        }
        Utilities.BypassAllTriggers = true;
        insert schools;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(5, schools.size());
        return schools;
    }
    
    @IsTest(seeAllData=false)
    public static List<Class__c> createListOfClassesTestData() 
    {
        List<School__c> schools = TestDataFactory.createListOfSchoolsTestData();
        System.assertEquals(5, schools.size());
        
        List<Class__c> classes = (List<Class__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_CLASS, false, 5);
        
        Integer cnt = 0;
        for(Class__c cl : classes) 
        {
            if(cnt != 0 && cnt != 1) 
            {
            	cl.School__c = schools[1].Id;    
            }
            else 
            {
                cl.School__c = schools[0].Id;
            }
            cnt++;
        }
        Utilities.BypassAllTriggers = true;
        insert classes;
        Utilities.BypassAllTriggers = false;
        
        List<Class__c> classesResults = [SELECT ID 
                                         FROM Class__c 
                                         WHERE School__c =: schools[0].Id
                                        ];
        System.assertEquals(2, classesResults.size());
        
        classesResults = [SELECT ID 
                          FROM Class__c 
                          WHERE School__c =: schools[1].Id
                         ];
        System.assertEquals(3, classesResults.size());
        return classes;
    }
    
    @IsTest(seeAllData=false)
    public static List<Class__c> createListOfClassesTestDataWithTriggerEnabled() 
    {
        List<School__c> schools = TestDataFactory.createListOfSchoolsTestData();
        System.assertEquals(5, schools.size());
        
        List<Class__c> classes = (List<Class__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_CLASS, false, 5);
        
        Integer cnt = 0;
        for(Class__c cl : classes) 
        {
            if(cnt != 0 && cnt != 1) 
            {
            	cl.School__c = schools[1].Id;    
            }
            else 
            {
                cl.School__c = schools[0].Id;
            }
            cnt++;
        }
        insert classes;
        
        List<Class__c> classesResults = [SELECT ID 
                                         FROM Class__c 
                                         WHERE School__c =: schools[0].Id
                                        ];
        System.assertEquals(2, classesResults.size());
        
        classesResults = [SELECT ID 
                          FROM Class__c 
                          WHERE School__c =: schools[1].Id
                         ];
        System.assertEquals(3, classesResults.size());
        
        List<School__c> schoolsResults = [SELECT ID, No_Of_Class__c
                                          FROM School__c 
                                          WHERE ID =: schools[0].Id
                                         ];
        System.assertEquals(1, schoolsResults.size());
        System.assertEquals(2, schoolsResults[0].No_Of_Class__c);
        
        schoolsResults = [SELECT ID, No_Of_Class__c
                          FROM School__c 
                          WHERE ID =: schools[1].Id
                         ];
        System.assertEquals(1, schoolsResults.size());
        System.assertEquals(3, schoolsResults[0].No_Of_Class__c);
        
        return classes;
    }
    
    @IsTest(seeAllData=false)
    public static List<Student__c> createListOfStudentsTestData() 
    {
        List<Class__c> classes = TestDataFactory.createListOfClassesTestData();
        System.assertEquals(5, classes.size());
        
        List<Student__c> students = (List<Student__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_STUDENT, false, 5);
        System.assertEquals(5, students.size());
        
        Integer cnt = 0;
        for(Student__c st : students) 
        {
            if(cnt != 0 && cnt != 1) 
            {
            	st.Class__c = classes[1].Id;    
            }
            else 
            {
                st.Class__c = classes[0].Id;
            }
            cnt++;
        }
        Utilities.BypassAllTriggers = true;
        insert students;
        Utilities.BypassAllTriggers = false;
        
        List<Student__c> studentsResults = [SELECT ID 
                                            FROM Student__c 
                                            WHERE Class__c =: classes[0].Id
                                           ];
        System.assertEquals(2, studentsResults.size());
        
        studentsResults = [SELECT ID 
                           FROM Student__c 
                           WHERE Class__c =: classes[1].Id
                          ];
        System.assertEquals(3, studentsResults.size());
        return students;
    }
    
    @IsTest(seeAllData=false)
    public static List<Student__c> createListOfStudentsTestDataWithTriggerEnabled() 
    {
        List<Class__c> classes = TestDataFactory.createListOfClassesTestDataWithTriggerEnabled();
        System.assertEquals(5, classes.size());
        
        classes = [SELECT ID, School__c 
                   FROM Class__c];
        
        List<Student__c> students = (List<Student__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_STUDENT, false, 5);
        System.assertEquals(5, students.size());
        
        Integer cnt = 0;
        for(Student__c st : students) 
        {
            if(cnt != 0 && cnt != 1) 
            {
                st.Class__c = classes[2].Id;
            }
            else 
            {
                st.Class__c = classes[0].Id;
            }
            cnt++;
        }
        insert students;
        System.assertEquals(5, students.size());
        return students;
    }    
}