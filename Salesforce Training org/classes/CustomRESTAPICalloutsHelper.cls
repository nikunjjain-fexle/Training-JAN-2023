/**
*
*  Purpose          :   Apex class that is having methods to make various types of Custom REST API (webservice) callouts
*
*  Created Date     :   11/28/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class CustomRESTAPICalloutsHelper 
{
    public static HTTPResponse createWebServiceLogRecord() 
    {
        //With Framework
        HttpCalloutService service = new HTTPCalloutService(Constants.HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS_REST_SERVICE);
        service.setHeaderParameter(Constants.CHAR_AUTHORIZATION, Constants.CHAR_BEARER + Constants.CHAR_BLANK_SPACE + UserInfo.getSessionId());
        service.setRequestBody(CustomRESTAPICalloutsHelper.createWebServiceLogJSON());
        
        HTTPResponse res = service.sendRequest();
        return res;
    }
    
    public static String createWebServiceLogJSON()
    {
        String requestBody = Constants.CHAR_BLANK;
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField(Constants.FIELD_NAME_DIRECTION, Constants.CHAR_CUSTOM_REST_RESOURCE_SERVICE);
        gen.writeEndObject();
        requestBody = gen.getAsString();    
        return requestBody;        
    }
}