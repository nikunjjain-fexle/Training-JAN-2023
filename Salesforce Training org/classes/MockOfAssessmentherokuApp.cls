/**
*
*  Purpose          :   Test Class to have Assessment Questions.
*
*  Created Date     :   
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
@isTest(seeAlldata=false)
global class MockOfAssessmentherokuApp implements HttpCalloutMock{
    global HTTPResponse  respond (HTTPRequest  req)
    {
        HTTPResponse resp = new HTTPResponse();
        resp.setHeader('Content-Type', 'application/json');
        resp.setBody('{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}');
        resp.setStatusCode(200);
        return resp;
    }
}