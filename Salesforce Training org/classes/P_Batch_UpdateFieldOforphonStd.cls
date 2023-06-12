public class P_Batch_UpdateFieldOforphonStd Implements Database.Batchable<sObject>, Database.stateful
{
    String Query='';
    integer i=1;
    String log='';
    
    @TestVisible static Integer emailLimits;
    public P_Batch_UpdateFieldOforphonStd(String input)
    {
        Query=input;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(Query);
    }
    
    public void execute (Database.BatchableContext bc, List<Student__c>listOfStd)
    {
        List<Student__c>updatelistOfStd=new List<Student__c>();
        
        for(Student__c s:listOfStd)
        {
            s.Test_TBD__c='Test '+i;
            i++;
            updatelistOfStd.add(s);
        }
        log=Utilities.getErrorLogMessageForRecords(updatelistOfStd);
        System.debug('000000000000000'+log);
    }
    
    public void Finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String []{'nikunj.jain@fexle.com'});
        mail.setSubject('Updated Orphan Student');
        mail.setPlainTextBody('Batch Processing is Completed !'+log);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        P_Batch_UpdateFieldOforphonStd.emailLimits=Limits.getEmailInvocations();
    }

}