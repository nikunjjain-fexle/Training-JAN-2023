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
@isTest(seeAllData=false)
public class Batch_UpdateOppStageNameField_Test {
    
    @Testsetup static void setup()
    {
        List<Opportunity>oppList=TestDataFactory.creationOfOpportunityTestData();
        
    }
    @isTest(seeAllData=false)
    public static void testUpdateOppStageNameField()
    {
        List<Opportunity>oppList=[SELECT Id,StageName, Probability FROM Opportunity];
        
        System.assertEquals(6, oppList.size());
        
        Test.startTest();
        
        List<Opportunity>updateOppList=[SELECT Id,StageName, Probability FROM Opportunity];
        integer i=0;
        for(Opportunity op: updateOppList)
        {
            if(i<3)
            {
                op.Probability=80;
            }
            else if(i==4)
            {
                op.Probability=20;
            }
            else
            {
                op.Probability=55;
            }
            i++;
        }
        update updateOppList;
        Batch_UpdateOpportunityStageNameField batchObj=new Batch_UpdateOpportunityStageNameField('SELECT Id, stageName, Probability FROM Opportunity WHERE LastModifiedDate >= Last_N_Days : 1');
        Id batchId=database.executeBatch(batchObj);
        
        Test.stopTest();
        List <Opportunity> finalUpdateoppList=[SELECT Id, StageName, Probability FROM Opportunity WHERE StageName = 'Closed Won'];
        
        System.debug('finalUpdateoppList------'+finalUpdateoppList);
        System.assertEquals(3, finalUpdateoppList.size());
        
    }

}