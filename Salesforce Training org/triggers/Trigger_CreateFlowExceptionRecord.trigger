/*
 * Purpose       : Trigger Of Platform Event
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 08-04-2023
 * 
 * Revision Log  : V_1.0 Created  08-04-2023
 *                
 */ 
trigger Trigger_CreateFlowExceptionRecord on Create_Flow_Exception_handling__e (after insert) 
{
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            CreateFlowExceptionRecordHandler.createFlowExceptionRecord(trigger.new);
        }
    }

}