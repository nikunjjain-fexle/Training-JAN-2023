/*
 * Purpose       : Test Class Of HerokuApp
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 27-03-2023
 * 
 * Revison Log   : V_1.0 27-03-2023
 *                 
 */

@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
   
    global HTTPResponse respond(HTTPRequest req) 
    {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}