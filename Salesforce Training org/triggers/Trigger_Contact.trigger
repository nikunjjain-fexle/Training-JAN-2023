/*
 * Purpose       : Trigger Class of Contact object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023 
 *                 V_1.1 Modified By Nikunj 28-4-2023
 */ 
trigger Trigger_Contact on Contact (before update,after update, before insert,after insert, before delete, after delete) {

    try
    {
        if(Utilities.ByPassAllTriggers)
        {
            return;
        }
        
        if(Trigger.isBefore){
            if (Trigger.isInsert || Trigger.isUpdate )
            {
                //AssesmentPractice.insertionOfContact(Trigger.new,Trigger.oldMap);
                //ContactTriggerHelper.insertionOfContactUpdateOwnfieldToRelateAssociateField(Trigger.new);
                
            }
        }
        if(Trigger.isAfter){
            if (Trigger.isInsert || Trigger.isUpdate /*|| Trigger.isDelete*/)
            {
                   //AssesmentPractice.reparentContact(Trigger.new,Trigger.oldMap);
                 //AssesmentPractice.populateTotalSalaryOnAccount(Trigger.new,Trigger.oldMap);
                //Practic--AssesmentPractice.insertionOfContactUpdate(Trigger.new);
               //ContactTriggerHandler.updateSequenceNumberFieldOnContact(Trigger.new, Trigger.oldMap);
               
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