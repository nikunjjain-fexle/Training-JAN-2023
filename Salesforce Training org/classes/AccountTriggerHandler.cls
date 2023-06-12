/*
 * Purpose     : Delete Realted Record of Account When Account Field Will be Changed.
 * 
 * Created By  : Nikunj Jain
 * 
 * Create Date : 03-04-2023
 * 
 * Resion Log  : V_1.0 created  03-04-2023
 *
 */


public class AccountTriggerHandler {
    
    public static void countCloseWonAndLostOnAccount(List<Account>accList, Map<Id,Account>mapOfAccount)
    {
       
        if(accList != null )
        {
            Set<id> setOfAccIdsForClosedWon=new  Set<id>();
            Set<id> setOfAccIdsForClosedLost=new  Set<id>();
            
            for(Account acc : accList)
            {
                if(acc.Number_Of_Close_Won__c != null && acc.Number_Of_Close_Won__c != mapOfAccount.get(acc.Id).Number_Of_Close_Won__c  )
                {
                    setOfAccIdsForClosedWon.add(acc.Id);
                }
                if(acc.Number_Of_Close_Lost__c != null && acc.Number_Of_Close_Lost__c !=mapOfAccount.get(acc.Id).Number_Of_Close_Lost__c)
                {
                    setOfAccIdsForClosedLost.add(acc.id);
                }
            }
            
            if(setOfAccIdsForClosedWon != null && setOfAccIdsForClosedWon.size() > 0)
            {
                
                
                List<Account> newUpdateAcccountList=new List<Account>();
                for(Account acc : [SELECT ID , Number_Of_Close_Won__c, (SELECT Id, StageName  FROM opportunities WHERE StageName='Closed Won' ) FROM Account WHERE Id=:setOfAccIdsForClosedWon])
                {
                    acc.Number_Of_Close_Won__c=acc.opportunities.size();
                    newUpdateAcccountList.add(acc);
                }
                
                if(newUpdateAcccountList.size() > 0)
                {
                    Utilities.BypassAllTriggers=true;
                    update newUpdateAcccountList;
                    Utilities.BypassAllTriggers=false;
                    
                }
                
            }
            
            if(setOfAccIdsForClosedLost != null && setOfAccIdsForClosedLost.size() >0)
            {
                
                    List<Account> newUpdateAcccountList=new List<Account>();
                   
                    for(Account acc : [SELECT ID , Number_Of_Close_Lost__c, (SELECT Id, StageName  FROM opportunities WHERE StageName='Closed Lost' ) FROM Account WHERE Id=:setOfAccIdsForClosedLost])
                    {
                        acc.Number_Of_Close_Lost__c=acc.opportunities.size();
                        newUpdateAcccountList.add(acc);
                    }
                   
                    
                    if(newUpdateAcccountList.size() > 0)
                    {
                        Utilities.BypassAllTriggers=true;
                        update newUpdateAcccountList;
                        Utilities.BypassAllTriggers=false;
                        
                    }
                
            }
        }
    }
    
     public static void updateContactPhoneNumberIfAccountPhoneChange(List<Account>accList,Map<Id,Account>mapOfAcc)
     {
         Set<Id>accIds=new Set<Id>();
         
         for(Account acc :accList)
         {
             if(mapOfAcc !=null && acc.Phone != mapOfAcc.get(acc.id).Phone)
             {
                 accIds.add(acc.id);
             }
         }
         
         List<contact>updatedConList=new List<contact>();
         
         for(Account acc :[SELECT Id, Phone, (SELECT ID, AccountId FROM Contacts)  FROM Account WHERE Id IN :accIds])
         {
             List<contact>conList=acc.contacts;
             for(contact con :conList)
             {
                 con.Phone=acc.Phone;
                 updatedConList.add(con);
             }
         }
         if(updatedConList.size() > 0)
         {
             update updatedConList;
         }
     }
    
    public static void deleteContactIfAccountFieldChange(List<Account>accList,Map<Id,Account>mapOfAcc)
    {
        
        Set<Id> accIds = new Set<Id>();
        
        for(Account acc:accList)
        {
            if(mapOfacc!=null && acc.Type != mapOfacc.get(acc.id).Type){
                accIds.add(acc.id);
            }
        }
        
        List<Contact> conList = [SELECT Id, Name , AccountId FROM Contact WHERE AccountId =:accIds];
        
        if(!conList.isEmpty())
        {
            delete conList;
        }
    }
    
    
}