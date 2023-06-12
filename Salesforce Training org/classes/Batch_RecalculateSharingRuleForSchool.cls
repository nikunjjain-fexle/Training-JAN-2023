/*
 * Purpose       : Re-calculation of Sharing Rule of School object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 10-03-2023
 * 
 * Revison Log   : V_1.0
 *                 
*/
public class Batch_RecalculateSharingRuleForSchool implements Database.Batchable<Sobject>
{
    @TestVisible static Integer emailLimits;
    public String query;
    public String log;
    
    public Batch_RecalculateSharingRuleForSchool()
    {
        query='SELECT ID FROM School__c';
        log='';
    }
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return DataBase.getQueryLocator(query);
    }
    public void execute (Database.BatchableContext bc, List<School__c>listOfSchool)
    {
        log=Utilities.getErrorLogMessageForRecords(listOfSchool);
    }
    public void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'Nikunj.jain@fexle.com'});
        mail.setReplyTo('Batch@acme.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Processing Completed');
        mail.setPlainTextBody('Batch Process has Completed'+ log +' '+Query);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        Batch_RecalculateSharingRuleForSchool.emailLimits=Limits.getEmailInvocations();
        
    }
}