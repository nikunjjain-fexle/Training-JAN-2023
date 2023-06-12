global class Sch_OrphanStudent implements Schedulable {
    
    global void execute(SchedulableContext sc)
    {
         P_Batch_UpdateFieldOforphonStd obj=new P_Batch_UpdateFieldOforphonStd('SELECT Id FROM Student__c WHERE Class__c = null AND Class__r.school__c = null');
        id batchJob=Database.executeBatch(obj);
    }

}