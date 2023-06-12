/**
*
*  Purpose          :   Apex class that is having methods to make various types of Standard SOAP API callouts
*
*  Created Date     :   11/17/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class StandardSOAPAPICalloutsHelper 
{
    public static HTTPResponse createWebServiceLogRecord() 
    {
        //Normal Way
        String s ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com" xmlns:urn1="urn:sobject.enterprise.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
        s += '<soapenv:Header>';
        s += '<urn:SessionHeader>';
        s += '<urn:sessionId>';
        s += UserInfo.getSessionId();
        s += '</urn:sessionId>';
        s += '</urn:SessionHeader>';
        s += '</soapenv:Header>';
        s += '<soapenv:Body>';
        s += '<urn:create>';
        s += '<urn:sObjects xsi:type="urn1:Web_Service_Log__c">';
        s += '<Direction__c>Sample Inbound Account One</Direction__c>';
        s += '</urn:sObjects>';
        s += '</urn:create>';
        s += '</soapenv:Body>';
        s += '</soapenv:Envelope>';
        
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(System.Label.CREATE_WEB_SERVICE_LOG_SOAP_API);
        req.setMethod(Constants.HTTP_CALLOUT_OPERATION_POST);
        req.setBody(s);
        req.setHeader(Constants.HEADER_ATTRIBUTE_CONTENT_TYPE, Constants.HEADER_CONTENT_TYPE_TEXT_XML);
        req.setHeader(Constants.HEADER_ATTRIBUTE_SOAP_ACTION, Constants.CHAR_DOUBLE_QUOTES_INSIDE_SINGLE_QUOTES);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;        
    }

	public static HTTPResponse createWebServiceLogRecordUsingXML(String direction) 
    {
        if(String.isBlank(direction)) 
        {
            direction = Constants.HTTP_CALLOUT_DIRECTION_SF_TO_SF;
        }
        
        HttpRequest req = new HttpRequest();
        //req.setEndpoint(System.Label.CREATE_WEB_SERVICE_LOG_SOAP_API);
        req.setMethod(Constants.HTTP_CALLOUT_OPERATION_POST);
        req.setBody(StandardSOAPAPICalloutsHelper.getCreateWebServiceLogXml(direction));
        req.setHeader(Constants.HEADER_ATTRIBUTE_CONTENT_TYPE, Constants.HEADER_CONTENT_TYPE_TEXT_XML);
        req.setHeader(Constants.HEADER_ATTRIBUTE_SOAP_ACTION, Constants.CHAR_DOUBLE_QUOTES_INSIDE_SINGLE_QUOTES);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;  
    }
    
    public static HTTPResponse createWebServiceLogRecordUsingXMLInIdealWay(String direction) 
    {
        if(String.isBlank(direction)) 
        {
            direction = Constants.HTTP_CALLOUT_DIRECTION_SF_TO_SF;
        }
        
        //With Framework
        HttpCalloutService service = new HTTPCalloutService(Constants.HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS_SOAP);
        service.setRequestBody(StandardSOAPAPICalloutsHelper.getCreateWebServiceLogXml(direction));
        service.setHeaderParameter(Constants.HEADER_ATTRIBUTE_SOAP_ACTION, Constants.CHAR_DOUBLE_QUOTES_INSIDE_SINGLE_QUOTES);
        HTTPResponse res = service.sendRequest();
        return res;
    }
   
    public static String getCreateWebServiceLogXml(String direction) 
    {
        if(String.isBlank(direction)) 
        {
            direction = Constants.HTTP_CALLOUT_DIRECTION_SF_TO_SF;
        }
        
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument(null, Constants.CHAR_ONE_POINT_ZERO);
        
        w.writeProcessingInstruction(Constants.CHAR_CREATE, Constants.CHAR_WEB_SERVICE_LOG_DATA);
        w.writeStartElement(Constants.NAMESPACE_SOAP_ENV, Constants.CHAR_ENVELOPE, Constants.SOAP_ENVELOPE_URL);
        w.writeNamespace(Constants.NAMESPACE_SOAP_ENV, Constants.SOAP_ENVELOPE_URL);
        w.writeNamespace(Constants.NAMESPACE_URN, Constants.SOAP_URN_ENTERPRISE_SOAP_URL);
        w.writeNamespace(Constants.NAMESPACE_URNL, Constants.SOAP_URN_SOBJECT_ENTERPRISE_SOAP_URL);
        w.writeNamespace(Constants.NAMESPACE_XSI, Constants.SOAP_ENVELOPE_URL_XMLSCHEMA);
        
        w.writeStartElement(Constants.NAMESPACE_SOAP_ENV, Constants.CHAR_HEADER, Constants.CHAR_BLANK);
        w.writeStartElement(Constants.NAMESPACE_URN, Constants.CHAR_SESSION_HEADER, Constants.CHAR_BLANK);
        
        w.writeStartElement(Constants.NAMESPACE_URN, Constants.CHAR_SESSION_ID, Constants.CHAR_BLANK);
        w.writeCharacters(UserInfo.getSessionId());
        w.writeEndElement();
        
        w.writeEndElement();
        w.writeEndElement();
      
		w.writeStartElement(Constants.NAMESPACE_SOAP_ENV, Constants.CHAR_BODY, Constants.CHAR_BLANK);
        w.writeStartElement(Constants.NAMESPACE_URN, Constants.CHAR_CREATE, Constants.CHAR_BLANK);
        
        w.writeStartElement(Constants.NAMESPACE_URN, Constants.CHAR_SOBEJCTS, Constants.CHAR_BLANK);
        w.writeAttribute(Constants.NAMESPACE_XSI, Constants.CHAR_BLANK, Constants.CHAR_TYPE, Constants.NAMESPACE_WEB_SERVICE_LOG_OBJECT_NAME);
        
        w.writeStartElement(Constants.CHAR_BLANK, Constants.FIELD_NAME_DIRECTION, Constants.CHAR_BLANK);
        w.writeCharacters(direction);
        w.writeEndElement();
        
        w.writeEndElement();
        w.writeEndElement();
        
        w.writeEndElement();
        
        w.writeEndDocument();
        String xmlOutput = w.getXmlString();
        w.close();
        return xmlOutput;
    }
}