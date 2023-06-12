/*
 * Purpose       : Trigger Of opportunity Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 30-03-2023
 * 
 * Revision Log  : V_1.0 Created 30-03-2023
 * 
*/

trigger Trigger_Opportunity on Opportunity (after insert,after Update, after delete, before update, before insert, before delete) {

    try
    {
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert )
            {
                //OpportunityTriggerHandler.insertOfOpportunityUpadteClasedWonAndLostOnAccount(Trigger.new,Trigger.oldMap);
                 //AssesmentPractice.sequencingOfAmountOnOpportunity(Trigger.new,Trigger.oldMap);
                //OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(Trigger.new);
                //OpportunityTriggerHandler.testClassOfPreventToUpdateStageNameField(Trigger.new,Trigger.oldMap);
                //OpportunityTriggerHandler.updationOfOppAmountField(Trigger.new,Trigger.oldMap);
                //OpportunityTriggerHandler.deleteOfOppAmountField(Trigger.oldMap);
                //OpportunityTriggerHandler.oppDeleteRelatedRecordAlsoDelete(Trigger.old);
                JustPractice.insretionAndUpdationOpportunity(Trigger.new,Trigger.oldMap);
            }
            if(trigger.isUpdate)
            {
                //AssesmentPractice.sequencingOfAmountOnOpportunity(Trigger.new,Trigger.oldMap);
            }
            if (Trigger.isDelete)
            {
                 //AssesmentPractice.sequencingOfAmountOnOpportunity(Trigger.new,Trigger.oldMap);
                 //OpportunityTriggerHandler.deletionOfOpportunityUpadteClasedWonAndLostOnAccount(Trigger.old,Trigger.oldMap);
            }
        }
        if(Trigger.isBefore){
            if(Trigger.isDelete || Trigger.isUpdate)
            {
                
                //OpportunityTriggerHandler.insertionOfOppUpdateAccountsAmountField(Trigger.old);
                //OpportunityTriggerHandler.oppDeleteRelatedRecordAlsoDelete(Trigger.old);
                //------preventToUpdateStageNameField----Assignment
                //OpportunityTriggerHandler.preventToUpdateStageNameField(Trigger.new,Trigger.oldMap);
                
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