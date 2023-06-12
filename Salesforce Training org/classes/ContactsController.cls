/*
 * Purpose       : Trigger Class of class Controller object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 18-05-2023
 * 
 * Revision Log  : V_1.0 
 * 
 */ 
public with sharing class ContactsController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(String accountId)
    {
        return [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE AccountId  =:accountId];
    }
}

/*

public  with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(id accountId)
    {
        return [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE AccountId  =:accountId];
    }

}
*/