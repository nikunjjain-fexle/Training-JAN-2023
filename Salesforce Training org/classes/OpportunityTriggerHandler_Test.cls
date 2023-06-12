/*
 * Purpose       : Write Test Class Of Opportunity Update Field Of Total Amount Of Accont object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 10-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023 
 */

@isTest(SeeAllData=False)
public class OpportunityTriggerHandler_Test {
    
    
    @testSetup static void setup()
    {
        List<opportunity>oppList=TestDataFactory.creationOfOpportunityTestData();
        
    }
    
    @isTest(SeeAllData=False)
    public static void testClassOfPreventToUpdateStageNameField()
    {
        List<opportunity>oppList=[SELECT ID FROM Opportunity];
        
        System.assertEquals(6, oppList.size());
        
        List<Opportunity> newOppList=new List<Opportunity>();
        String Log='';
        
        Test.StartTest();
        
        integer op=0;
        for(Opportunity opp:oppList)
        {
            if(op<3) 
            {
                opp.StageName ='Qualification';
                opp.CloseDate=System.Today()-7;
            }
            else 
            {
                opp.StageName ='Value Position';
                opp.CloseDate=System.Today()+2;
            }
            op++;
            newOppList.add(opp);
        }
        
        // This Reuseble Method Use to Avoid  Updation Failure
        //Log=Utilities.getErrorLogMessageForRecords(newOppList);
        
        Database.SaveResult [] updatedListOfOppRecord=Database.update(newOppList, false);

        Test.stopTest();
        
        List<opportunity>updateOppList=[SELECT Id, CloseDate, StageName FROM Opportunity WHERE StageName='Value Position'];
        
        //Check here Number of Record SuccessFully Updated
       
        System.assertEquals(3, updateOppList.size());
        
        System.assert(updatedListOfOppRecord[0].isSuccess() == false, 'Result should not be successful');
        System.assert(updatedListOfOppRecord[1].isSuccess() == false, 'Result should not be successful');
        System.assert(updatedListOfOppRecord[2].isSuccess() == false, 'Result should not be successful');
        
        
        Integer successRecord=0;
        Integer failRecord=0;
        for(Database.SaveResult  opp:updatedListOfOppRecord)
        {
            if(!opp.issuccess())
            {
                successRecord++;
            }
            else
            {
                failRecord++;
            }
        }
        
        System.assertEquals(3, successRecord);
        System.assertEquals(3, failRecord);
        
        //System.assert(updatedListOfOppRecord[3].isSuccess() == false, 'Result should not be successful');
        
        //System.assert(updatedListOfOppRecord.getErrors().size() == 3);
     
        
        
        
        
    }
    
    
    
    
    
    
    
    /*
    public static  List<Opportunity>listOfOpportunity=new List<Opportunity>();
    
    @testsetup Static void setup()
    {
        Account acc=new Account();
        acc.Name='DeleteAccount';
        acc.Total_Amount__c=0;
        insert acc;
        
        Opportunity opp1=new Opportunity();
        opp1.Name='opp1';
        opp1.CloseDate=System.today();
        opp1.StageName='Prospecting';
        opp1.AccountId=acc.id;
        opp1.Amount=2000;
        //insert opp1;
        listOfOpportunity.add(opp1);
        
        Opportunity opp2=new Opportunity();
        opp2.Name='opp2';
        opp2.CloseDate=System.today();
        opp2.StageName='Prospecting';
        opp2.AccountId=acc.id;
        opp2.Amount=2000;
        //insert opp2;
        listOfOpportunity.add(opp2);
        
        
        Opportunity opp3=new Opportunity();
        opp3.Name='opp3';
        opp3.CloseDate=System.today();
        opp3.StageName='Prospecting';
        opp3.AccountId=acc.id;
        opp3.Amount=2000;
        //insert opp3;
        listOfOpportunity.add(opp3);
        
        insert listOfOpportunity;
        
    }
    
    @isTest(SeeAllData=False)
    public static void testInsertionOpportunityTriggerHandler()
    {
        List<Opportunity>listOfOpp=[SELECT Id, Name From Opportunity ];
        System.assertEquals(3, listOfOpp.size());
        
        Test.startTest();
        //OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(listOfOpportunity);
        Test.stopTest();
        List<Account>listOfUpdatedOpp=[SELECT Id, Name, Total_Amount__c From Account WHERE Name='DeleteAccount'];
        
        System.assertEquals(6000, listOfUpdatedOpp[0].Total_Amount__c);
        
    }
    
    @isTest(SeeAllData=False)
    public static void testDeletionOpportunityTriggerHandler()
    {
        List<Opportunity>listOfOpp=[SELECT Id, Name From Opportunity ];
        System.assertEquals(3, listOfOpp.size());
        
        System.debug('****size******'+listOfOpp.size());
        Test.startTest();
        
        //OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(listOfOpportunity);
        
        List<Opportunity>listOfOppDeletion=[SELECT id, Name, Amount FROM Opportunity WHERE Name='opp2'];
        
        delete listOfOppDeletion;
        
        System.debug('#$%^&*'+listOfOppDeletion);
       
        Test.stopTest();
        
        Account listOfUpdatedOpp=[SELECT Id, Name, Total_Amount__c From Account WHERE Name='DeleteAccount'];
        
        System.debug('**********'+listOfUpdatedOpp);
        
        System.assertEquals(4000, listOfUpdatedOpp.Total_Amount__c);
        
    }
    
    
    @isTest(SeeAllData=False)
    public static void testUpdationOfOpportunityTriggerHandler()
    {
        List<Opportunity>listOfOpp=[SELECT Id, Name From Opportunity ];
        System.assertEquals(3, listOfOpp.size());
        
        System.debug('**********'+listOfOpp.size());
        Test.startTest();
        
        //OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(listOfOpportunity);
        
        List<Opportunity>listOfOppDeletion=[SELECT id, Name, Amount FROM Opportunity WHERE Name='opp1'];
        System.debug('#$%^&*'+listOfOppDeletion);
        
        for(Opportunity o:listOfOppDeletion)
        {
            o.Amount=6000;
        }
        
        update listOfOppDeletion;
        System.debug('#$%^&*'+listOfOppDeletion); 
        Test.stopTest();
        List<Account>listOfUpdatedOpp=[SELECT Id, Name, Total_Amount__c From Account WHERE Name='DeleteAccount'];
        System.debug('**********'+listOfUpdatedOpp);
        System.assertEquals(10000, listOfUpdatedOpp[0].Total_Amount__c);
        
    }*/
    
    

}