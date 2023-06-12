/** 
 * Purpuse : Write Trigger on opportunity Whenever opp insert and update and deleted
 * 
 * Created by : Nikunj jain
 * 
 * Created Date :06-06-2023
 * 
 **/
public class JustPractice {
    
    public static void updationOfAccount(List<Account>listOfAccount, Map<id,Account>mapOfAccount)
    {
        
        if(listOfAccount!=null)
        {
            set<Id> accIds = new set<Id>();
            set<String> accType = new set<String>();
            for(Account acc : listOfAccount!=null ? listOfAccount : mapOfAccount.values())
            {
                if(acc.Type =='instance account' || acc.Type=='shipping account')
                {
                    accIds.add(acc.id);
                    accType.add(acc.Type);
                }
            }
            if(accIds!= null && accIds.size()>0)
            {
                System.debug('accIds===>'+accIds);
                System.debug('accType===>'+accType);
                
                List<Contact> conList = [SELECT Id, Account.Type FROM Contact WHERE AccountId =:accIds];
                
                System.debug('conList===>'+conList);
                if(conList != null && conList.size()>0)
                {
                    Map<String,Id> mapOfAccountStrigAndId = new Map<String,Id>();
                    //List<Account> listOfOccureAccount = [SELECT Id, Name FROM Account WHERE Name =:accType];
                    for(Account acc :[SELECT Id, Name FROM Account WHERE Name =:accType])
                    {
                        if(!mapOfAccountStrigAndId.containsKey(acc.Name))
                        {
                            mapOfAccountStrigAndId.put(acc.Name,acc.Id);
                        }
                        
                    }
                    if(mapOfAccountStrigAndId.size()>0)
                    {
                        List<Contact> listOfFinalUpdate = new List<Contact>();
                        for(contact con :conList)
                        {
                            // accType is set Of String
                            if(con.Account.Type==('instance account'))
                            {
                                
                                con.AccountId=mapOfAccountStrigAndId.get(con.Account.Type);
                                listOfFinalUpdate.add(con);
                                
                            }
                            else if(con.Account.Type==('shipping account'))
                            {
                                con.AccountId=mapOfAccountStrigAndId.get(con.Account.Type);
                                 listOfFinalUpdate.add(con);
                                 
                            }
                        }
                        System.debug('listOfFinalUpdate===>'+listOfFinalUpdate);
                        if(!listOfFinalUpdate.isEmpty())
                        {
                            update listOfFinalUpdate;
                        }
                    }
                }
                    
                    
                    /*
                    System.debug('listOfOccureAccount===>'+listOfOccureAccount);
                    if(listOfOccureAccount.size()>0)
                    {
                        List<Contact> listOfFinalUpdate = new List<Contact>();
                        for(contact con :conList)
                        {
                            // accType is set Of String
                            if(accType.contains('instance account'))
                            {
                                
                                con.AccountId=listOfOccureAccount[0].Id;
                                listOfFinalUpdate.add(con);
                                System.debug('Yes instance');
                            }
                            else if(accType.contains('shipping account'))
                            {
                                con.AccountId=listOfOccureAccount[0].Id;
                                 listOfFinalUpdate.add(con);
                                 System.debug('Yes shipping');
                            }
                        }
                        System.debug('listOfFinalUpdate===>'+listOfFinalUpdate);
                        if(!listOfFinalUpdate.isEmpty())
                        {
                            update listOfFinalUpdate;
                        }
                    }*/
            }
            
            
        }
    }
    
    
    public static void insretionAndUpdationOpportunity(List<opportunity>listOfOpp, Map<id,Opportunity>mapOfOpportinity)
    {
        if(listOfOpp!=null)
        {
            set<Id> setOfAccIds = new set<Id>();
            for(opportunity opp : listOfOpp!=null ? listOfOpp : mapOfOpportinity.values())
            {
                if(opp.Amount != null && opp.Amount != mapOfOpportinity.get(opp.id).Amount)
                {
                    setOfAccIds.add(opp.AccountId);
                }
                else
                {
                    setOfAccIds.add(opp.AccountId);
                }
                
            }
            if(setOfAccIds!= null && setOfAccIds.size()>0)
            {
                System.debug('Yes here');
                Decimal temp=0;
                Map<Id,Decimal> mapOfTotalAmountOfAccountsOpportunity =new  Map<Id,Decimal>();
                for(Opportunity op :[SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId =:setOfAccIds])
                {
                    temp=op.Amount+temp;
                    if(mapOfTotalAmountOfAccountsOpportunity.containsKey(op.AccountId))
                    {
                        mapOfTotalAmountOfAccountsOpportunity.put(op.AccountId,(mapOfTotalAmountOfAccountsOpportunity.get(op.AccountId)+temp));
                    }
                    else
                    {
                        mapOfTotalAmountOfAccountsOpportunity.put(op.AccountId,temp);
                    }
                }
                if(mapOfTotalAmountOfAccountsOpportunity.size()>0 && mapOfTotalAmountOfAccountsOpportunity!= null)
                {
                    System.debug('Yes here');
                    List<Account> listOfAccount = new  List<Account>();
                    for(Account acc : [SELECT Id, Total_Amount__c FROM Account WHERE Id=:setOfAccIds])
                    {
                        acc.Total_Amount__c=mapOfTotalAmountOfAccountsOpportunity.get(acc.Id);
                        listOfAccount.add(acc);
                    }
                    if(!listOfAccount.isEmpty())
                    {
                        System.debug('Yes here Update'+listOfAccount);
                        update listOfAccount;
                    }
                }
            }
        }
    }

}