/**
*
*  Purpose          :	Batch job to create Web Service Log Records Via Rest Webservice REST API.
*
*  Created Date     :  	11/18/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Batch_CreateWebServiceLogsViaRestService implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts
{
    public String query;
    public String log;
    
    @TestVisible static Integer emailLimits;
    
    public Batch_CreateWebServiceLogsViaRestService() 
    {
        query = Constants.CHAR_BLANK;
        log = Constants.CHAR_BLANK;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope)
    {
        //Create multiple web service log records via SOAP API
        for(sObject s : scope) 
        {
            CustomRESTAPICalloutsHelper.createWebServiceLogRecord();
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {System.Label.ADMIN_USER_EMAIL_ADDRESS});
        mail.setReplyTo(System.Label.REPLY_TO_EMAIL_ADDRESS);
        
        mail.setSenderDisplayName(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaRestService + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                                  Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING);
        
        mail.setSubject(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaRestService + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                        Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING_COMPLETED);
        
        mail.setPlainTextBody(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaRestService + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                              Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING_HAS_COMPLETED + Constants.CHAR_BLANK_SPACE + log + 
                              Constants.CHAR_BLANK_SPACE + query);
        
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Batch_CreateWebServiceLogsViaRestService.emailLimits = Limits.getEmailInvocations();
    }
}