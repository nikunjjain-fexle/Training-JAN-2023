global class Ass_Batch_Update_Orphone_Student_S implements schedulable{
    global void execute(SchedulableContext SC) {
      Ass_Batch_Update_Orphone_Student obj=new Ass_Batch_Update_Orphone_Student('Select Id,Test_TBD__c FROM Student__c WHERE Class__c = null AND Class__r.school__c = null');
      Id BatchJon=database.executeBatch(obj);
   }

}