public class StandardRESTAPICalloutsHelper {
    public static HTTPResponse createWebServiceLogRecord() 
    {
        //With Framework
        HttpCalloutService service = new HTTPCalloutService(Constants.HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS);
        HTTPResponse response = service.sendRequest();
        return response;
    }
    
    public static HTTPResponse createWebServiceLogRecordWithWrapperDetails(WebServiceLogsWrapper wServiceLogsWrapper) 
    {
        if(wServiceLogsWrapper != null) 
        {
            //Without Framework
            /*HttpRequest req = new HttpRequest();
req.setEndpoint(System.Label.ENDPOINT_CREATE_WEB_SERVICE_LOG);
req.setMethod('POST');
req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
req.setHeader('Content-Type', 'application/json');
req.setTimeout(12000);
req.setBody(requestBody);

// Create a new http object to send the request object
// A response object is generated as a result of the request  
Http http = new Http();
HTTPResponse res = http.send(req);
System.debug('@@@@@ ' + res.getBody());*/
            
            //With Framework
            HttpCalloutService service = new HTTPCalloutService('CreateWebServiceLogs');
            //HttpCalloutService service = new HTTPCalloutService(Constants.HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS);
            service.setHeaderParameter(Constants.CHAR_AUTHORIZATION, Constants.CHAR_BEARER + Constants.CHAR_BLANK_SPACE + UserInfo.getSessionId());
            service.setRequestBody(StandardRESTAPICalloutsHelper.createWebServiceLogJSON(wServiceLogsWrapper));
            
            HTTPResponse res = service.sendRequest();
            return res;
        }
        return null;
    }
    
    public static String createWebServiceLogJSON(WebServiceLogsWrapper wServiceLogsWrapper)
    {
        String requestBody = Constants.CHAR_BLANK;
        
        if(wServiceLogsWrapper != null) 
        {
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField(Constants.FIELD_NAME_DIRECTION, Utilities.parseNull(wServiceLogsWrapper.direction));
            gen.writeStringField(Constants.FIELD_NAME_ENDPOINT, Utilities.parseNull(wServiceLogsWrapper.endpoint));
            gen.writeStringField(Constants.FIELD_NAME_ERROR_MESSAGE, Utilities.parseNull(wServiceLogsWrapper.errorMessage));
            gen.writeStringField(Constants.FIELD_NAME_RECORD_ID, Utilities.parseNull(wServiceLogsWrapper.recordID));
            gen.writeStringField(Constants.FIELD_NAME_REQUEST_MESSAGE, Utilities.parseNull(wServiceLogsWrapper.requestMessage));
            gen.writeStringField(Constants.FIELD_NAME_REQUEST_MESSAGE_LOG, Utilities.parseNull(wServiceLogsWrapper.requestMessageLog));
            gen.writeDateTimeField(Constants.FIELD_NAME_REQUEST_SENT, wServiceLogsWrapper.requestSent);
            gen.writeStringField(Constants.FIELD_NAME_RESPONSE_MESSAGE, Utilities.parseNull(wServiceLogsWrapper.responseMessage));
            gen.writeStringField(Constants.FIELD_NAME_RESPONSE_MESSAGE_LOG, Utilities.parseNull(wServiceLogsWrapper.responseMessageLog));
            gen.writeDateTimeField(Constants.FIELD_NAME_RESPONSE_RECEIVED, wServiceLogsWrapper.responseReceived);
            gen.writeStringField(Constants.FIELD_NAME_WEB_SERVICE_CLASS, Utilities.parseNull(wServiceLogsWrapper.webServiceClass));
            gen.writeStringField(Constants.FIELD_NAME_WEB_SERVICE_METHOD, Utilities.parseNull(wServiceLogsWrapper.webServiceMethod));
            gen.writeStringField(Constants.FIELD_NAME_WEB_SERVICE_NAME, Utilities.parseNull(wServiceLogsWrapper.webServiceName));
            gen.writeEndObject();
            requestBody = gen.getAsString(); 
            System.debug('@@@@@ requestBody: '+gen.getAsString());
        }
        return requestBody;        
    }
    
}