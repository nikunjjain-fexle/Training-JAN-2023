/*
 * Purpose       : Write Class For updation of Contact Field
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 25-03-2023
 * 
 * Revision Log  :
 * 
 * Trigger to First create two fields on CONTACT object paid amount(currency) and sequential number(number) 
   And now according to paid amount give them sequential number do this with the help of trigger.
*/

public Without Sharing class ContactTriggerHandler
{
    public static void updatePhoneNumberOfContactAlsoUpdatedOnAccount(List<Contact>listOfContact)
    {
        Set<Id>accIds=new Set<Id>();
        
        List<String>listOfContact1=new List<String>();
        
        for(Contact con:listOfContact)
        {
            if(con.LeadSource=='Web')
            {
                accIds.add(con.AccountId);
                listOfContact1.add(con.Phone);
            }
        }
       
        List<Account>accList=new List<Account>();
        
        for(Account acc:[SELECT ID, Phone FROM Account WHERE ID IN :accIds])
        {
            acc.phone=listOfContact1[0];
            accList.add(acc);
        }
        if(!accList.isEmpty())
        {
            update accList;
        }
        
    }
    
    public static void updateSequenceNumberFieldOnContact(List<Contact>ConList,Map<Id,Contact>conOldMap)
    {       
        Set<Id>accIds=new Set<Id>();
        
        for(Contact con :ConList != null ? ConList : conOldMap.Values())
        {
            if(ConList != null || (con.Paid_Amount__c !=conOldMap.get(con.Id).Paid_Amount__c) || conOldMap.keySet() != null)
            {
                accIds.add(con.AccountId);
            }
        }
        List<Contact>updateList=new List<contact>();
        for(Account acc : [SELECT ID, (SELECT ID, Paid_Amount__c,Sequence_Number__c FROM Contacts ORDER BY Paid_Amount__c ASC) FROM Account WHERE Id =:accIds])
        {
            integer i=1;
            List<contact>listOfCon=acc.contacts;
            for(contact c: listOfCon)
            {
                c.Sequence_Number__c=i;
                i++;
                updateList.add(c);
            }
        }
        if(updateList.size() > 0)
        {
            Utilities.ByPassAllTriggers=true;
            update updateList;
            Utilities.ByPassAllTriggers=false;
        }
       
    }
   
    
    
}