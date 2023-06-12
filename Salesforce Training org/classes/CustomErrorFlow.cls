/**
*
*  Purpose          :	CustomErrorFlow class
*
*  Created Date     :  	06/05/2023
*
*  Created By       :  	Nikunj jain
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public with sharing class CustomErrorFlow
{
    @InvocableMethod(label='Throw Custom flow Exception' description='Outputs messages to the debug log')
    public static void trace(List<String> exceptionMessage) 
    {
        throw new CustomException('Error Occured: '+exceptionMessage[0]);
    }

    
}