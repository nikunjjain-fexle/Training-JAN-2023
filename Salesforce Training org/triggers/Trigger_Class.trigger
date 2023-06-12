/*
 * Purpose       : Trigger Of Class Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 30-03-2023
 * 
 * Revision Log  : V_1.0 Created 30-03-2023
 * 
*/


trigger Trigger_Class on Class__c (before update, after update, before insert, after insert ,before delete, after delete) {

    try
    {
        if(Trigger.isBefore ){
            if (Trigger.isInsert || Trigger.isUpdate )
            {
                 //AssessmentClassHandler.updateNoOfClassInBeforeCase(Trigger.new,Trigger.oldMap);
                //ClassTriggerHandler.showErrorWhenTryToDeleteChildRecord(Trigger.old);
                //ClassTriggerHandler.ClassDeletion(Trigger.old,Trigger.oldMap);
                //Future_CalloutClass.makeCallout();
            }
            if(Trigger.isDelete)
            {
               
            }
        }
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert || Trigger.isDelete)
            {
                  //AssessmentClassHandler.insertionAndDeletionOfClass(Trigger.new,Trigger.oldMap);
                 
                 //Future_CalloutClass.makeCallout();
                //ClassTriggerHandler.updateNumberOfClassesDetails(Trigger.new,Trigger.oldMap);
            }
            if(Trigger.isupdate)
            {
                //AssessmentClassHandler.insertionAndDeletionOfClass(Trigger.new,Trigger.oldMap);
            }
        }
    }
    catch(Exception e)
    {
        integer i=0;
        if(Trigger.isDelete)
        {
            Trigger.Old[i].addError(e.getMessage());
        }
        else
        {
            Trigger.New[i].addError(e.getMessage());
        }
    }

}