/**
 * Purpose     : Practice Assessment Question
 * 
 * Created By  : Nikunj jain
 * 
 * Create Date :
 * 
 * Resion Log  :
 *
*/
public class Ass_Batch_Update_Orphone_Student implements Database.Batchable<sObject>,Database.stateful
{
    public static  String query = '';
    
    public static String Log = '';
    
    public Ass_Batch_Update_Orphone_Student(String input)
    {
        query = input;
    }
    public static Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Student__c> listOfSobject)
    {
        Integer i=0;
        List<Student__c>listofupdateStudentField=new List<Student__c>();
        for(Student__c s: listOfSobject)
        {
            
            s.Test_TBD__c='Test'+i;
            listofupdateStudentField.add(s);
            i++;
        }
        Log=Utilities.getErrorLogMessageForRecords(listofupdateStudentField);
    }
    public void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
        List<String> toAddress=new List<String>{'nikunj.jain@fexle.com','nikunj1889@gmail.com'};
        email.setSenderDisplayName('Bach is processing Completed');
        email.setToAddresses(toAddress);
        email.setPlainTextBody('he batch Apex job processed '+ Log);
        Messaging.sendEmail(new Messaging.SingleEmailMessage []{email});
        
    }
}