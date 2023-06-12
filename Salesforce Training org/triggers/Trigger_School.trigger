/*
 * Purpose       : Trigger Of School Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 29-03-2023
 * 
 * Revision Log  : V_1.0 Created 29-03-2023
 * 
*/ 


trigger Trigger_School on School__c (before update, after update, before insert, after insert ,before delete, after delete) {
   
    try
    {
        if(Utilities.ByPassAllTriggers || (Utilities.areTriggersOnThisObjectBypassed(Constants.OBJECT_NAME_SCHOOL)))
        {
            return;
        }
        
        if(Trigger.isBefore){
            if ( Trigger.isDelete )
            {
                //AssessmentSchoolHandler.upadteNoOfStudentInBeforeCase(Trigger.new,Trigger.oldMap);
                //AssessmentSchoolHandler.upadteNoOfClassInBeforeCase(Trigger.new,Trigger.oldMap);
                SchoolTriggerHandler.updateNoOfStudentsDetailsInBeforeCase(Trigger.new,Trigger.oldMap);
                //SchoolTriggerHandler.updateNoOfClassesDetailsInBeforeCase(Trigger.new,Trigger.oldMap);
            }
        }
        if(Trigger.isAfter){
            if (Trigger.isUpdate )
            {
                SchoolTriggerHandler.doApexSharingCalculations(Trigger.new,Trigger.oldMap);
                //SchoolTriggerHandler.doApexSharingCalculations(Trigger.new,Trigger.oldMap);
                //SchoolTriggerHandler.updateNoOfStudentsDetails(Trigger.new,Trigger.oldMap);
               //SchoolTriggerHandler.updateNoOfClassesDetails(Trigger.new,Trigger.oldMap);
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