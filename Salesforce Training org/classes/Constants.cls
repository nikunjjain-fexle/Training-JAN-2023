/**
*
*  Purpose          :   Apex Class to have the constants
*
*  Created Date     :   09/30/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/

public Without Sharing class Constants {

   public static final String CHAR_DOUBLE_QUOTES_INSIDE_SINGLE_QUOTES = '""';
    public static final String CHAR_BLANK = '';
    public static final String CHAR_BLANK_SPACE = ' ';
    public static final String CHAR_DASH = '-';
    public static final String CHAR_ALL = 'ALL';
    public static final String CHAR_ANIMALS = 'animals';
    public static final String CHAR_AUTHORIZATION = 'Authorization';
    public static final String CHAR_BEARER = 'Bearer';
    public static final String CHAR_TEST = 'Test';
    public static final String CHAR_CHAINED_JOB_1 = 'CHAINED_JOB_1';
    public static final String CHAR_CHAINED_JOB_2 = 'CHAINED_JOB_2';
    public static final String CHAR_UNSUPPORTED = 'Unsupported';
    public static final String CHAR_ERROR = 'Error';
    public static final String CHAR_COLON = ':';
    public static final String CHAR_SUCCESS_WITH_COLON = 'SUCCESS : ';
    public static final String CHAR_ERROR_WITH_COLON = 'ERROR : ';
    public static final String CHAR_ONE_POINT_ZERO = '1.0';
    public static final String CHAR_WEB_SERVICE_LOG_DATA = 'Web Service Log Data';
    public static final String CHAR_CREATE = 'create';
    public static final String CHAR_BACK_SLASH = '/';
    public static final String CHAR_COMMA = ',';
    public static final String CHAR_ARE_YOU_KIDDING = 'Are you kidding !!';
    public static final String CHAR_CUSTOM_REST_RESOURCE_SERVICE = 'Custom Rest Resource Service';
    public static final String CHAR_DOUBLE_UNDERSCORE_C = '__c';
    public static final String CHAR_DOUBLE_UNDERSCORE_R = '__r';
    public static final String CHAR_FIELD_LIST = 'FIELD_LIST';
    public static final String CHAR_RECORD_LIST = 'RECORD_LIST';
    
    public static final String ID_FIELD_NAME = 'Id';
    
    public static final String URL_PARAMETER_NAME_ID = 'id';
    
    public static final String CHAR_RECORD_DELETED_SUCCESSFULLY = 'Record Deleted Successfully';
    public static final String CHAR_RECORD_CREATED_SUCCESSFULLY = 'Record Created Successfully';
    public static final String CHAR_RECORD_UPDATED_SUCCESSFULLY = 'Record Updated Successfully';
    
    public static final String ERROR_UNABLE_TO_FIND_RECORD = 'Unable to find record !!';
    
    public static final String NAMESPACE_SOAP_ENV = 'soapenv';
    public static final String NAMESPACE_URN = 'urn';
    public static final String NAMESPACE_URNL = 'urn1';
	public static final String NAMESPACE_XSI = 'xsi';    
    public static final String CHAR_ENVELOPE = 'Envelope';
    public static final String CHAR_HEADER = 'Header';
    public static final String CHAR_SESSION_HEADER = 'SessionHeader';
    public static final String CHAR_SESSION_ID = 'sessionId';
    public static final String CHAR_BODY = 'Body';
    public static final String CHAR_SOBEJCTS = 'sObjects';
    public static final String CHAR_TYPE = 'type';
    public static final String NAMESPACE_WEB_SERVICE_LOG_OBJECt_NAME = 'urn1:Web_Service_Log__c';
    public static final String SOAP_ENVELOPE_URL = 'http://schemas.xmlsoap.org/soap/envelope/';
    public static final String SOAP_URN_ENTERPRISE_SOAP_URL = 'urn:enterprise.soap.sforce.com';
	public static final String SOAP_URN_SOBJECT_ENTERPRISE_SOAP_URL = 'urn:sobject.enterprise.soap.sforce.com';
	public static final String SOAP_ENVELOPE_URL_XMLSCHEMA = 'http://www.w3.org/2001/XMLSchema-instance';    
    
    public static final String SCHOOL_ID = 'schoolId';
    public static final String NUM_OF_CLASSES = 'numOfClasses';
    
    public static final String CLASS_NAME_Batch_DeleteOutOrphanStudentRecords = 'Batch_DeleteOutOrphanStudentRecords';
    public static final String CLASS_NAME_Batch_RecalculateSharingRuleForSchools = 'Batch_RecalculateSharingRuleForSchools';
    public static final String CLASS_NAME_Batch_CreateWebServiceLogsViaSOAP = 'Batch_CreateWebServiceLogsViaSOAP';
    public static final String CLASS_NAME_Batch_CreateWebServiceLogsViaRestService = 'Batch_CreateWebServiceLogsViaRestService';
    
    public static final String OBJECT_NAME_CONTACT = 'Contact';
    public static final String OBJECT_NAME_INDIVIDUAL = 'Individual';
    public static final String OBJECT_NAME_ACCOUNT = 'Account';
    public static final String OBJECT_NAME_SCHOOL = 'School__c';
    public static final String OBJECT_NAME_CLASS = 'Class__c';
    public static final String OBJECT_NAME_STUDENT = 'Student__c';
    public static final String OBJECT_NAME_XYZ = 'xyz__c';
    public static final String OBJECT_NAME_FLOW_EXCEPTION_EVENT = 'Flow_Exception_Event__e';
    
    public static final String SHARING_ACCESS_TYPE_READ = 'Read';
    
    public static final String SHARING_REASON_APEX_SHARING = 'Apex_Sharing__c';
    
    public static final String HTTP_CALLOUT_OPERATION_GET = 'GET';
    public static final String HTTP_CALLOUT_OPERATION_POST = 'POST';
    
    public static final String HTTP_CALLOUT_STATUS_SUCCESS = 'SUCCESS';
    public static final String HTTP_CALLOUT_STATUS_ERROR = 'ERROR';
    
    public static final String SOQL_STRING_FROM_KEYWORD = ' FROM ';
    public static final String SOQL_STRING_SELECT_KEYWORD = ' SELECT ';
    public static final String SOQL_STRING_LIMIT_KEYWORD = ' LIMIT ';
    public static final String SOQL_STRING_WITH_SECURITY_ENFORCED_KEYWORD = 'WITH SECURITY_ENFORCED';
    
    public static final String HEADER_ATTRIBUTE_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_ATTRIBUTE_SOAP_ACTION = 'SOAPAction';
    public static final String HEADER_CONTENT_TYPE_TEXT_XML = 'text/xml';
    public static final String HEADER_CONTENT_TYPE_APPLICATION_JSON = 'applicatin/json';
    
    public static final String HTTP_CALLOUT_DIRECTION_SF_TO_HEROKU = 'SFDC-->Heroku';
    public static final String HTTP_CALLOUT_DIRECTION_SF_TO_SF = 'SF-->SF';
    public static final String HTTP_CALLOUT_DIRECTION_3rd_Party_TO_SF = '3rd Party-->SF';
    
    public static final Integer HTTP_CALLOUT_SUCCESS_CODE = 200;
    
    public static final String HTTP_CALLOUT_NAME_HEROKU_APP_GET_ANIMALS = 'HerokuAppGetAnimals';
    public static final String HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS = 'CreateWebServiceLogs';
    public static final String HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS_SOAP = 'CreateWebServiceLogsSOAP';
    public static final String HTTP_CALLOUT_NAME_CREATE_WEB_SERVICE_LOGS_REST_SERVICE = 'CreateWebServiceLogsRestService'; 
    public static final String HTTP_CALLOUT_NAME_TEST_METADATA = 'TestMetadata';
    
    public static final String HEROKU_APP_INTEGRATION_CLASS_NAME = 'HerokuAppIntegrationManager';
    public static final String HEROKU_UPDATE_USERS_METHOD_NAME = 'makeHerokuAppCalloutAndUpdateUsers';
    
    public static final String BATCH_PROCESSING = 'Batch Processing';
    public static final String BATCH_PROCESSING_COMPLETED = 'Batch Process Completed';
    public static final String BATCH_PROCESSING_HAS_COMPLETED = 'Batch Processing has Completed';
    public static final String BATCH_CREATE_WEB_SERVICE_LOGS = 'Batch to Create Web Service Logs';
    public static final String BATCH_CREATE_WEB_SERVICE_LOGS_RS = 'Batch to Create Web Service Logs (RS)';
    
    public static final String FIELD_NAME_ID = 'Record_ID__c';
    public static final String FIELD_NAME_NAME = 'Name';
    public static final String FIELD_NAME_DIRECTION = 'Direction__c';
    public static final String FIELD_NAME_ENDPOINT = 'Endpoint__c';
    public static final String FIELD_NAME_ERROR_MESSAGE = 'Error_Message__c';
    public static final String FIELD_NAME_RECORD_ID = 'Record_ID__c';
    public static final String FIELD_NAME_REQUEST_MESSAGE = 'Request_Message__c';
    public static final String FIELD_NAME_REQUEST_MESSAGE_LOG = 'Request_Message_Log__c';
    public static final String FIELD_NAME_REQUEST_SENT = 'Request_Sent__c';
    public static final String FIELD_NAME_RESPONSE_MESSAGE = 'Response_Message__c';
    public static final String FIELD_NAME_RESPONSE_MESSAGE_LOG = 'Response_Message_Log__c';
    public static final String FIELD_NAME_RESPONSE_RECEIVED = 'Response_Recieved__c';
    public static final String FIELD_NAME_WEB_SERVICE_CLASS = 'Web_Service_Class__c';
    public static final String FIELD_NAME_WEB_SERVICE_METHOD = 'Web_Service_Method__c';
    public static final String FIELD_NAME_WEB_SERVICE_NAME = 'Web_Service_Name__c';
    
    public static final String QUERY_GET_ORPHAN_STUDENTS = 'SELECT Id, Class__c, Name FROM Student__c WHERE Class__c = null';
    public static final String QUERY_GET_ALL_SCHOOLS_WITH_IDS = 'SELECT ID FROM School__c';
    public static final String QUERY_GET_ALL_SCHOOLS_LIMIT_2 = 'SELECT ID, Name FROM School__c LIMIT 2';
    public static final String QUERY_GET_ALL_SCHOOLS_LIMIT_1 = 'SELECT ID, Name FROM School__c LIMIT 1';
    
}