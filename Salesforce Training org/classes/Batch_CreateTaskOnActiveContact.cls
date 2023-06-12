/*
 * Purpose       : Write Batch Class on Contact Object Create one Task Every One Contact Record 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 28-04-2023
 * 
 * Revision Log  : V_1.0 Created 28/04/2023 
 *                 
 * 
 */ 

public Without Sharing class Batch_CreateTaskOnActiveContact implements Database.Batchable<sObject>,Database.stateful
{
    public String query;
    // List Of New task insert
    public List<Task> newTaskOfContact = new List<Task>();
    
    // List of confirm Task is create one per contact
    public List<Contact> conList =new List<Contact>();
    @TestVisible static Integer emailLimits;
    
    
    public  Batch_CreateTaskOnActiveContact(String input)
    {
        this.query=input;
    }
    
    public Database.QueryLocator Start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> listOfContact)
    {
        
        for(Contact con : listOfContact)
        {
            if(con.Task_Created__c == false && con.Contact_Type__c =='Active')
            {
                Task tsk = new Task();
                tsk.Subject = 'Test Task';
                tsk.Status = 'Open';
                tsk.Priority = 'Normal';
                tsk.WhoId = con.ID;
                tsk.OwnerId = con.OwnerId;
                con.Task_Created__c=true;
                conList.add(con);
                newTaskOfContact.add(tsk);
                
                
            }
            
        }
        
        System.debug('@@@@  All new Task Created List : -'+ newTaskOfContact);
        
    }
    
    public void finish(Database.BatchableContext bc)
    {
        if((newTaskOfContact != null && newTaskOfContact.size() > 0) && (conList!= null && conList.size() > 0))
        {
            
            insert newTaskOfContact;
            update conList;
        }
    }
    
}
// SELECT ID, Contact_Type__c,Task_Created__c FROM Contact WHERE Contact_Type__c = 'Active' AND Task_Created__c = false