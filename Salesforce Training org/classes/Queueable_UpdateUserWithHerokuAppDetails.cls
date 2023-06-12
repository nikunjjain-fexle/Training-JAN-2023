/*
 * Purpose       : Queueable Job Class
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 12-04-2023
 * 
 * Version       : V_0.1
*/
public without sharing class Queueable_UpdateUserWithHerokuAppDetails extends QueueableChainJob implements Queueable, Database.AllowsCallouts
{
    private Set<Id> setOfSchoolsIds;
    String msg;
    
    public Queueable_UpdateUserWithHerokuAppDetails(Set<Id> setOfSchoolsIds) 
    {
        this.setOfSchoolsIds = setOfSchoolsIds;
    }
    
    public Queueable_UpdateUserWithHerokuAppDetails(Set<Id> setOfSchoolsIds, String msg)
    {
        this.setOfSchoolsIds = setOfSchoolsIds;
        this.msg = msg;
    }
    
    /*
     * Sample Code to execute the Queueable job for testing prospective via standard way
		
		Set<Id> setOfSchoolIds = new Set<Id>{'a005g000039LNs4'};
		Queueable_UpdateUserWithHerokuAppDetails updateJob = new Queueable_UpdateUserWithHerokuAppDetails(setOfSchoolIds, 'JOB_A');
		ID jobID = System.enqueueJob(updateJob);
		
		Sample Code to execute the Queueable job for testing prospective via loosly coupled way
			
			Set<Id> setOfSchoolIds = new Set<Id>{'a005g000039LNs4'};
			Queueable_UpdateUserWithHerokuAppDetails a = new Queueable_UpdateUserWithHerokuAppDetails(setOfSchoolIds, 'JOB_A');
			Queueable_ChainJobForCreateWServiceLogs b = new Queueable_ChainJobForCreateWServiceLogs(webServiceLogsWrap, 'JOB_B');
			a.setNextJob(b);
			system.enqueueJob(a);
		Similarly, we can chain multiple jobs as needed and add required conditions to add jobs. Sample code below:
			
			QueueableApexDemo nextChainJob;
			QueueableApexDemo a = new QueueableApexDemo('JOB_A');
			nextChainJob = a;
            if(UserInfo.getUserType() == 'Standard')
			{
                ChainedJob b = new ChainedJob('JOB_B');
            	nextChainJob.setNextJob(b);
            	nextChainJob = b;
            }
			
		In above code, the second job is chained, only if current user's UserType is Standard, else second job is not chained.
	*/
    
    public void execute(QueueableContext context) 
    {
        system.debug('@@@@@ This msg is = '  + msg);
        
        if(this.setOfSchoolsIds != null && this.setOfSchoolsIds.size() > 0) 
        { 
            WebServiceLogsWrapper webServiceLogsWrap = HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(setOfSchoolsIds);
            
            System.debug('@@@@@ webServiceLogsWrap ' + webServiceLogsWrap);
            
            //Only execute further logic if first callout executed and parsed successfully
            
            if(webServiceLogsWrap != null) 
            {
                if(webServiceLogsWrap.isSuccessfullyExecuted) 
                {
                    List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c 
                                                         FROM User 
                                                         WHERE Id =: System.Label.INTEGERATION_USER_RECORD_ID
                                                         AND IsActive = true
                                                        ];
                    
                    //Only execute further logic if "Heroku App Response" is not null/blank
                    if(integrationUserDetails.size() > 0 && String.isNotBlank(integrationUserDetails[0].Heroku_App_Response__c))
                    {
                        //Note: A key limitation to consider here is that Apex allows only one job to be enqueued via a Queueable job.
                        //Chain this job to next job by submitting the next job
                        Queueable_ChainJobForCreateWServiceLogs nextJob = new Queueable_ChainJobForCreateWServiceLogs(webServiceLogsWrap, Constants.CHAR_CHAINED_JOB_1);
                        System.enqueueJob(nextJob);
                        
                        //Tight coupling with Queueable Apex
                        //Now, in real world, you would not want your first class (Queueable_UpdateUserWithHerokuAppDetails) is tightly coupled 
                        //with second class (Queueable_ChainJobForCreateWServiceLogs). 
                        //Also, in reality, as you create more complex code, there may be need to dynamically decide jobs to be chained together at runtime.
                        
                        //Implement Loose Coupling with Chainable Interface
                        // Chain this job to next job by submitting the next job
                        //ID jobID = this.enqueueNextJob();
                    }    
                }    
            }
        }    
    }

}