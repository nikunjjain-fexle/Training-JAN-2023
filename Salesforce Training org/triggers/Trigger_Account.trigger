/*
 * Purpose       : Trigger Class of Account object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 07-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023 
 * 
 */ 

trigger Trigger_Account on Account (after update,after delete, before delete, before update, before insert,After insert) {
    
    if(Trigger.isBefore)
    { 
        if(Trigger.isInsert )
        {
               
            // Practice -- AssesmentPractice.copyBillingAddressToMaillingAddress(Trigger.new);
        }
        if(Trigger.isDelete)
        {
            //AssesmentPractice.showErrorOnAccount(Trigger.old);
        }
    }
    if(Trigger.isAfter)
    {
        
        if ( Trigger.isUpdate )
        {
             //AccountTriggerHandler.countCloseWonAndLostOnAccount(Trigger.new, Trigger.oldMap);
             //AssesmentPractice.AutoPopulateWebSiteAndAddressDetailsOnAcccountFromContact(Trigger.new, Trigger.oldMap);
             //AssesmentPractice.updateRelatedContactPhoneFiled(Trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.updateContactPhoneNumberIfAccountPhoneChange(Trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.deleteContactIfAccountFieldChange(Trigger.new,Trigger.oldMap);
            //P---AssesmentPractice.deleteContactIfAccountFieldChange(Trigger.new, Trigger.oldMap);
            //JustPractice.updationOfAccount(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isInsert)
        {
            //AssesmentPractice.insertionOfContactOnAccountField(Trigger.new);
        }
    }
    
}