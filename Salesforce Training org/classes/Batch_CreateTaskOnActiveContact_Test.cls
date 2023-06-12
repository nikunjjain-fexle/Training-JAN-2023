/*
 * Purpose       : Write Test Class Of Batch Class on Contact Object Create one Task Every One Contact Record 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 28-04-2023
 * 
 * Revision Log  : V_1.0 Created 28/04/2023 
 *                 
 * 
 */ 

@isTest(seeAlldata=false)
public class Batch_CreateTaskOnActiveContact_Test {
    
    @TestSetup static void setup()
    {
        List<Contact> listOfContact = testDatafactory.creationOfContactTestData();
    }
    
    @isTest(seeAlldata=false)
    public static void testCreateTaskOnActiveContact()
    {
        List<Contact> listCreatedContact=[SELECT Id,Contact_Type__c,Task_Created__c FROM Contact];
        System.assertEquals(200, listCreatedContact.size());
        
        
        Test.startTest();
        
        
        Batch_CreateTaskOnActiveContact obj =new Batch_CreateTaskOnActiveContact('SELECT ID, OwnerId, Contact_Type__c,Task_Created__c FROM Contact');
        Id bacthJob =Database.executeBatch(obj);
        
        Test.stopTest();
        
        
        
        list<Task> createdTask= [SELECT ID FROM Task];
        System.assertEquals(100, createdTask.size());
        
        
    }

}