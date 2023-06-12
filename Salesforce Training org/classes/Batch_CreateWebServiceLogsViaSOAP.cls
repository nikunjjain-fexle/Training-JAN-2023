/**
*
*  Purpose          :	Batch job to create Web Service Log Records Via SOAP API.
*
*  Created Date     :  	11/18/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Batch_CreateWebServiceLogsViaSOAP implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts
{
    public String query;
    public String log;
    
    @TestVisible static Integer emailLimits;
    
    public Batch_CreateWebServiceLogsViaSOAP() 
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
            StandardSOAPAPICalloutsHelper.createWebServiceLogRecordUsingXMLInIdealWay(String.valueOf(s.get(Constants.FIELD_NAME_NAME)));
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {System.Label.ADMIN_USER_EMAIL_ADDRESS});
        mail.setReplyTo(System.Label.REPLY_TO_EMAIL_ADDRESS);
        
        mail.setSenderDisplayName(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaSOAP + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                                  Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING);
        
        mail.setSubject(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaSOAP + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                        Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING_COMPLETED);
        
        mail.setPlainTextBody(Constants.CLASS_NAME_Batch_CreateWebServiceLogsViaSOAP + Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + 
                              Constants.CHAR_BLANK_SPACE + Constants.BATCH_PROCESSING_HAS_COMPLETED + Constants.CHAR_BLANK_SPACE + log + 
                              Constants.CHAR_BLANK_SPACE + query);
        
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Batch_CreateWebServiceLogsViaSOAP.emailLimits = Limits.getEmailInvocations();
        
        Batch_CreateWebServiceLogsViaRestService bCC = new Batch_CreateWebServiceLogsViaRestService();
        bCC.query = Constants.QUERY_GET_ALL_SCHOOLS_LIMIT_1;
        
        //Schedule the batch job run after 1 min
        String cronID = System.scheduleBatch(bCC, Constants.BATCH_CREATE_WEB_SERVICE_LOGS_RS + String.valueOf(System.now()), 1); 
        system.debug('@@@@@ cronID = '  + cronID);
    }
}