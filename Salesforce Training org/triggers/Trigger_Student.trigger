/*
 * Purpose       : Trigger Class of Student Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 03-04-2023
 * 
 * Revision Log  : V_1.0 Created 03-04-2023 
 * 
*/


trigger Trigger_Student on Student__c (before update, after update, before insert, after insert ,before delete, after delete) {
   
    // For Practice Purpose 
    try
    {
        if(Trigger.isBefore)
        {
         
            if(Trigger.isInsert)
            {
                
            }
            if(Trigger.isDelete)
            {
               
            }
        }
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert || Trigger.isDelete)
            {
                //AssessmentStudentHandler.insertionAndDeletionOfStudent(Trigger.new,Trigger.oldMap);
            }
            if(Trigger.isUpdate)
            {
                
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    try
    {
        if(Utilities.ByPassAllTriggers)
        {
            return;
        }
        
        if(Trigger.isBefore){
            if (Trigger.isInsert || Trigger.isUpdate ||Trigger.isDelete)
            {
                //StudentTriggerHandler.updateNoOfStudentsDetails(Trigger.new,Trigger.oldMap);
            }
        }
        if(Trigger.isAfter){
            if (Trigger.isInsert || Trigger.isUpdate ||Trigger.isDelete)
            {
                //StudentTriggerHandler.countNoOfStudentsDetails(Trigger.new,Trigger.oldMap);
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
    */

}