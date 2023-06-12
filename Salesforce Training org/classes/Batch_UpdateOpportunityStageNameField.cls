/*
* Purpose       : Write the batch class with given requirment The batch should be executed at a specific time each day, such as 2:00 AM.
                  The batch should only process Opportunities that meet certain criteria, such as those that have been modified in the last 24 hours.
                  The batch should log any errors that occur during processing
                  The batch should update the Stage field on each Opportunity record to a new value based on certain criteria.
                  The new value for the Stage field should be determined based on the Opportunity's Probability field.
                  If the Probability is greater than or equal to 75%, the Stage should be set to "Closed Won".
                  If the Probability is between 50% and 75%, the Stage should be set to "Negotiation/Review".
                  If the Probability is less than 50%, the Stage should be set to "Prospecting".
* 
* Created By    :
* 
* Created Date  :
* 
* Revision Log  :
 */

public without sharing class Batch_UpdateOpportunityStageNameField implements Database.Batchable<sObject>, Database.Stateful
{
    public String query = '';
    public  String log='';
    
    //DateTime dt = System.Now().addHours(-24);
    //SELECT Id,LastModifiedDate FROM Opportunity WHERE LastModifiedDate >=: System.Now().addHours(-24)
    //SELECT Id, stageName, Probability FROM Opportunity WHERE LastModifiedDate >= Last_N_Days : 1
    
    public Batch_UpdateOpportunityStageNameField(String input)
    {
        this.query=input;
    }
    public  Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    public void execute (Database.BatchableContext BC, List<Opportunity>oppList)
    {
        List<opportunity>updateOppList = new List<opportunity>();
        for(Opportunity opp: oppList)
        {
            if(opp.Probability >= 75 )
            {
                opp.StageName='Closed Won';
            }
            else if(opp.Probability > 50 &&  opp.Probability < 75.00)
            {
                opp.StageName='Negotiation/Review';
            }
            else if(opp.Probability  < 50)
            {
                opp.StageName='Prospecting';
            }
            updateOppList.add(opp);
        }
        Log=Utilities.getErrorLogMessageForRecords(updateOppList);
    }
    public void finish(Database.BatchableContext BC)
    {
        
    }
}