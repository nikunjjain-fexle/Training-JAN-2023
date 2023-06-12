/*
 * Purpose       : FlowDebugLogger Class of Debug Error Message For Flow
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 15-05-2023
 * 
 * Revision Log  : V_1.0 Created 15-05-2023
 * 
 */

public with sharing class FlowDebugLogger 
{
    @InvocableMethod(label='Log Debug Message' description='Outputs messages to the debug log')
    
    public static void trace(List<string> debugMessages)
    {
        for(String debugMessage : debugMessages)
        {
            System.debug('@@@@  '+debugMessage);
        }
    }
}