/**
*
*  Purpose          :   Apex Class for debug Error Message Of Flow.
*
*  Created Date     :   20-05-2023
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing  class FlowDebugLoggerForCollections 
{
    @InvocableMethod(label='Log Debug Message' description='Outputs messages to the debug log for Collections')
    
    public static void trace(List<List<String>> listOfDebugMessage)
    {
        for(List<String> debugMessages : listOfDebugMessage ){
            System.debug('@@@ debugMessages '+debugMessages);
            for(String debugMessage : debugMessages)
            {
                System.debug('@@@@  '+debugMessage);
            }
        }
        
    }
    
    
}