/*
 * Purpose       : Write Batch Class Update Field Of Orphone Student 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 06-04-2023
 * 
 * Version       : V_0.1
*/


public class Batch_UpdateOrphanStudent Implements Database.Batchable<sObject>,Database.stateful {
 
    public String query='';
    
    public String  studentId = '';
    
    
    Map<Id,String>errorMap=new Map<Id,String>();
    List<String>errorList=new List<String>();
   
    public Batch_UpdateOrphanStudent(String inputQuary)
    {
        query=inputQuary;
    }
    
    @TestVisible static Integer emailLimits;
    
    public Database.QueryLocator Start(Database.BatchableContext bc)
    {
       return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc,List<Student__c>stdList)
    {
        integer i=1;
        List<Student__c>updatedStduent=new List<Student__c>();
        
        for(Student__c s:stdList)
        {
           s.Test_TBD__c='hi'+i;
           updatedStduent.add(s);
           i++;
        }
        
        Database.SaveResult[] studentList = Database.update(updatedStduent,false);
        
        for(Database.SaveResult std: studentList)
        {
            if(!std.isSuccess()){
                String  log = '';
                for(Database.Error err: std.getErrors())
                {
                   log += err.getMessage()+ Constants.CHAR_BLANK_SPACE;               
                }
                errormap.put(std.getId(),log);
            }
        }
        
        
        for(Student__c std:stdList)
        {
            if(errorMap.containsKey(std.id))
            {
                String errorMessage=std.Name+Constants.CHAR_BLANK_SPACE+errorMap.get(std.id)+Constants.CHAR_BLANK_SPACE;
                errorList.add(errorMessage);
            }
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses( new String[] {'nikunj.jain@fexle.com'});
        mail.setSenderDisplayName('batch processing');
        mail.setSubject('Apex Sharing Recalculation ');
        mail.setPlainTextBody(errorList+Constants.CHAR_BLANK_SPACE);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Batch_UpdateOrphanStudent.emailLimits=Limits.getEmailInvocations();
    }
}