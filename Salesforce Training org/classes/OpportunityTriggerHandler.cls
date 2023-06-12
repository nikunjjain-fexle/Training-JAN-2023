/*
 * Purpose       : Write Class Of Opportunity Update Field Of Total Amount Of Accont object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 10-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023  100%
 * 
 * 
Today's Assignment:-
Create One Total Amount field On Account object
Opportunity- whenever a opportunity inserted ,deleted or the amount field of opportunity is updated then recalculate
the total amount field of account 
Note:-  The  Total amount field of account is the sum of amount of its all the child opportunities

*/
public class OpportunityTriggerHandler {
    
    public static void deletionOfOpportunityUpadteClasedWonAndLostOnAccount(List<Opportunity>oppList,Map<Id,Opportunity>oldOppLMap)
    {
        List<Opportunity>setOfDeleteOpp=new List<Opportunity>();
        for(Opportunity o : oldOppLMap.values())
        {
            setOfDeleteOpp.add(o);
        }
        if(setOfDeleteOpp!=null)
        {
            OpportunityTriggerHandler.insertOfOpportunityUpadteClasedWonAndLostOnAccount(setOfDeleteOpp,oldOppLMap);
        }
        
    }
    
    public static void insertOfOpportunityUpadteClasedWonAndLostOnAccount(List<Opportunity>oppList,Map<Id,Opportunity>oldOppLMap)
    {
        System.debug('oppList'+oppList);
        System.debug('oldOppLMap'+oldOppLMap);
        
        try
        {
            if(oppList != null || oldOppLMap != null)
            {
                Set<id>setAccIdsCosedWon=new Set<id>();
                Set<id>setAccIdsCosedLost=new Set<id>();
                
                for(Opportunity opp: oppList!= null ? oppList : oldOppLMap.Values() )
                {
                    if(oldOppLMap != null)
                    {
                        if(opp.StageName=='Closed Won' && opp.StageName != oldOppLMap.get(opp.id).StageName )
                        {
                            setAccIdsCosedWon.add(opp.AccountId);
                        }
                        
                        if(opp.StageName=='Closed Lost' && opp.StageName != oldOppLMap.get(opp.id).StageName)
                        {
                            setAccIdsCosedLost.add(opp.AccountId);
                        }
                    }
                    else
                    {
                        if(opp.StageName=='Closed Won'  )
                        {
                            setAccIdsCosedWon.add(opp.AccountId);
                        }
                        
                        if(opp.StageName=='Closed Lost' )
                        {
                            setAccIdsCosedLost.add(opp.AccountId);
                        }
                    }
                    
                }
                System.debug('setAccIdsCosedWon'+setAccIdsCosedWon);
                System.debug('setAccIdsCosedLost'+setAccIdsCosedLost);
                
                if(setAccIdsCosedWon.size() > 0 && setAccIdsCosedWon != null)
                {
                    List<Account>accList=new List<Account>();
                    
                    for(Account acc : [SELECT ID , Number_Of_Close_Won__c, (SELECT Id, StageName  FROM opportunities WHERE StageName='Closed Won' ) FROM Account WHERE Id=:setAccIdsCosedWon])
                    {
                        acc.Number_Of_Close_Won__c=acc.opportunities.size();
                        accList.add(acc);
                    }
                    
                    if(accList.size()>0)
                    {
                        Utilities.BypassAllTriggers=true;
                        update accList;
                        Utilities.BypassAllTriggers=false;
                    }
                }
                if(setAccIdsCosedLost.size() > 0 && setAccIdsCosedLost != null)
                {
                    List<Account>accList=new List<Account>();
                    
                    for(Account acc : [SELECT ID , Number_Of_Close_Won__c, (SELECT Id, StageName  FROM opportunities WHERE StageName='Closed Lost' ) FROM Account WHERE Id=:setAccIdsCosedLost])
                    {
                        acc.Number_Of_Close_Lost__c=acc.opportunities.size();
                        accList.add(acc);
                    }
                    
                    if(!accList.isEmpty())
                    {
                        Utilities.BypassAllTriggers=true;
                        update accList;
                        Utilities.BypassAllTriggers=false;
                    }
                }
            }
            
        }
        catch(Exception e)
        {
            System.debug('Error--------------------->'+e.getMessage()+' Line number ----------------->'+e.getLineNumber());
        }
        
    }
    
  
    public static void preventToUpdateStageNameField(List<opportunity>oppList, Map<Id,Opportunity>mapOfOpp)
    {
        
        if(mapOfOpp != null && oppList != null )
        {
            Set<Id>oppIds=new Set<Id>();
            for(Opportunity opp: oppList)
            {
                if(opp.StageName != mapOfOpp.get(opp.id).StageName && (opp.CloseDate < System.today()+1 ))
                {
                    opp.addError('You Can not Change This Stage Field Because You are Opportunity  Close Date is Not Tomorrow !');
                }
            }
        }
    }
    
    public static void insertionOfOppUpdateAccountsAmountField(List<Opportunity>oppList)
    {
        List<Account>accList=new List<Account>();
        
        Set<Id>accIds=new Set<Id>();
        
        for(Opportunity opp : oppList)
        {
            accIds.add(opp.AccountId);
        }
        
        if(!accIds.isEmpty())
        {
            Map<Id,Decimal>mapofAmountCount=new Map<Id,Decimal>();
            
            for(Opportunity opp:[SELECT ID, Amount, AccountID FROM Opportunity WHERE AccountId =:accIds])
            {
                Decimal temp=0;
                
                if(mapofAmountCount.containsKey(opp.AccountId))
                {
                    temp=mapofAmountCount.get(opp.AccountId);
                }
                temp = temp + opp.Amount;
                mapofAmountCount.put(opp.AccountId,temp);
            }
            
            for(Account acc:[SELECT ID, Total_Amount__c FROM Account WHERE Id =:mapofAmountCount.keySet()])
            {
                
                acc.Total_Amount__c = mapofAmountCount.get(Acc.id);
                accList.add(acc);
            }
        }
        
        if(!accList.isEmpty())
        {
            update accList;
        }
    }
    
    public static void updationOfOppAmountField(List<Opportunity> oppList , Map<Id,Opportunity> oldmapOfOpp)
    {
        for(opportunity opp:oppList)
        {
            if(oldmapOfOpp!=null && opp.Amount != oldmapOfOpp.get(opp.id).Amount)
            {
                OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(oppList);
            }
        }
    }
    
    public static void deleteOfOppAmountField (Map<Id,Opportunity> oldmapOfOpp)
    {
        List<Opportunity>setOfDeleteOpp=new List<Opportunity>();
        for(Opportunity o:oldmapOfOpp.values())
        {
            setOfDeleteOpp.add(o);
        }
        if(setOfDeleteOpp!=null)
        {
            OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(setOfDeleteOpp);
        }
    }
    
    /*
    public static void oppDeleteRelatedRecordAlsoDelete(List<Opportunity> oppList)
    {
        Set<Id>oppIds=new Set<Id>();
        for(opportunity opp:oppList)
        {
            oppIds.add(opp.AccountId);
        }
         
        List<Account>accdeleteList=[SELECT ID FROM Account WHERE Id In: oppIds];
        List<Contact>condeleteList=[SELECT ID FROM Contact WHERE AccountId IN: oppIds];
        
        Delete accdeleteList;
        Delete condeleteList;
        
        
    }*/
}