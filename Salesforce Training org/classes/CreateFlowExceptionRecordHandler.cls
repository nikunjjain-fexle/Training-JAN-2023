/**
*
*  Purpose          :   Apex class of Create Flow Exception Record Handler for Flow 
*
*  Created Date     :   19-05-2023
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/

public class CreateFlowExceptionRecordHandler 
{
	public static void createFlowExceptionRecord(List<Create_Flow_Exception_handling__e> listOfPlatformEventRecords)
    {
        try
        {
           
            List<Flow_Exception__c> listOfException = new List<Flow_Exception__c>();
        
            if(listOfPlatformEventRecords != null)
            {
                for(Create_Flow_Exception_handling__e ex : listOfPlatformEventRecords)
                {
                    Flow_Exception__c exp = new Flow_Exception__c();
                    
                    exp.Exception_Message__c=ex.Exception_Message__c;
                    exp.Object_API_Name__c=ex.Object_API_Name__c;
                    exp.Element_Category__c=ex.Element_Category__c;
                    exp.Flow_Name__c=exp.Flow_Name__c;
                    exp.Element_Name__c=ex.Element_Name__c;
                    exp.Record_ID__c=ex.Record_ID__c;
                    exp.Record_Name__c=ex.Record_Name__c;
                    
                    
                    listOfException.add(exp);
                }
            }
       
            if(listOfException.size() >0)
            {
                System.debug('@@@@@ listOfException: '+listOfException);
                Utilities.BypassAllTriggers=true;
                insert listOfException;
                Utilities.BypassAllTriggers=false;
            }
        }
        catch(Exception e)
        {
            System.debug('Error Message: '+ e.getMessage());
        }
    }
}