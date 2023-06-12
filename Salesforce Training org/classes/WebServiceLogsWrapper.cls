/**
*
*  Purpose          :  WebServiceLogsWrapper class
*
*  Created Date     :   19-05-2023
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class WebServiceLogsWrapper 
{
    public string direction {get; set;}
    public string endpoint {get; set;}
    public string errorMessage {get; set;}
    public string recordID {get; set;}
    public string requestMessage {get; set;}
    public string requestMessageLog {get; set;}
    public DateTime requestSent {get; set;}
    public string responseMessage {get; set;}
    public string responseMessageLog {get; set;}
    public DateTime responseReceived {get; set;}
    public string webServiceClass {get; set;}
    public string webServiceMethod {get; set;}
    public string webServiceName {get; set;}
    
    public Boolean isSuccessfullyExecuted {get; set;}
    
    public WebServiceLogsWrapper() 
    {
    	direction = Constants.CHAR_BLANK;
        endpoint = Constants.CHAR_BLANK;
        errorMessage = Constants.CHAR_BLANK;
        recordID = Constants.CHAR_BLANK;
        requestMessage = Constants.CHAR_BLANK;
        requestMessageLog = Constants.CHAR_BLANK;
        responseMessage = Constants.CHAR_BLANK;
        responseMessageLog = Constants.CHAR_BLANK;
        webServiceClass = Constants.CHAR_BLANK;
        webServiceMethod = Constants.CHAR_BLANK;
        webServiceName = Constants.CHAR_BLANK;
    }
}