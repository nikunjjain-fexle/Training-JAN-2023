/*
 * Purpose       : Test Class Of Class Trigger Helper
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 28-04-2023
 * 
 * Revision Log  : V_1.0 Created 28/04/2023 
 *                 
 * 
 */ 
public Without Sharing  class ContactTriggerHelper {
    
     
        
    // Question 1
    public static void insertionOfContactUpdateOwnfieldToRelateAssociateField(List<Contact> listOfContactDetails)
    {
        try
        {
            if(listOfContactDetails != null)
            {
                Set<Id>accIds = new Set<id>();
                
                for(Contact con : listOfContactDetails)
                {
                    if( con.status__c == null)
                    {
                        accIds.add(con.AccountId);
                    }
                    
                }
                
                if(accIds != null && accIds.size() > 0)
                {
                    List<Account> accList = [SELECT Id,property__r.status__c, Status__c FROM Account WHERE Id =: accIds];
                    
                    if(accList != null)
                    {
                        String tempStatus='';
                        for(Account acc : accList)
                        {
                            if(acc.Status__c != null)
                            {
                                tempStatus=acc.Status__c;
                            }
                            else if(acc.property__r.status__c != null)
                            {
                                tempStatus=acc.property__r.status__c;
                            }
                        }
                        
                        if(String.isNotBlank(tempStatus))
                        {
                            for(Contact con : listOfContactDetails)
                            {
                                con.status__c =tempStatus;
                            }
                        }
                        
                    }
                    
                }
            }
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
        
    }
    
    
   
}