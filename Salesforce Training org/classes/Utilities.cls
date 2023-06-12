/**
*
*  Purpose          :   Apex Class to have the utilities methods.
*
*  Created Date     :   07/19/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class Utilities 
{
    public static Boolean BypassAllTriggers = false;
    private static String pkgPrefix = null;
    
    public static String getPackagePrefix() 
    {
        if (pkgPrefix == null) 
        {
            List<ApexClass> nameSpaceClasses = [SELECT NamespacePrefix FROM ApexClass 
                                                WHERE Name =: Constants.CLASS_NAME_Batch_DeleteOutOrphanStudentRecords];
            if(nameSpaceClasses.size() > 0) 
            {
                pkgPrefix = nameSpaceClasses[0].NamespacePrefix;
            }
            else 
            {
                pkgPrefix = null;
            }
        }
        return pkgPrefix;
    }
    
    //Method to get the SFDC Instance base URL
    public static String getSfOrgBaseURL()
    {
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }
    
    //Method to get the SFDC Instance host URL
    public static String getSfInstance()
    {
        return System.URL.getSalesforceBaseUrl().getHost().remove('-api');
    }
    
    public static Schema.SObjectType getObjectTypeOnBasisOfObjectName(String objName) 
    {
        if (objName == null || String.isEmpty(objName)) 
        {
            return null;
        }
        else 
        {
            if (
                Type.forName(objName) != null &&
                ((SObject) Type.forName(objName).newInstance()) != null
            ) 
            {
                return ((SObject) Type.forName(objName).newInstance()).getSObjectType();
            }
            return null;
        }
    }
    
    public static String getErrorLogMessageForRecords(List<sObject> listOfSobjectRecords) 
    {
        String log = Constants.CHAR_BLANK;
        if(listOfSobjectRecords != null && listOfSobjectRecords.size() > 0) 
        {
            List<Database.SaveResult> results = Database.update(listOfSobjectRecords, false);
            for (Database.SaveResult result : results) 
            {
                if (!result.isSuccess())
                {
                    for (Database.Error err : result.getErrors())
                    {
                        log += Constants.CHAR_ERROR + Constants.CHAR_COLON + Constants.CHAR_BLANK_SPACE + err.getStatusCode() 
                            + Constants.CHAR_BLANK_SPACE + err.getMessage();
                    }
                }
            } 
        }
        return log;
    }
    
    public static boolean areTriggersOnThisObjectBypassed(String objectName) 
    {
        Boolean bypassTrigger = false;
        
        if(String.isNotBlank(objectName)) 
        {
            //Get the Bypass Custom Setting record for this user
            Bypass_Logic__c bypassLogic = Bypass_Logic__c.getInstance(UserInfo.getUserId());
            
            //Check to see if our Bypass Object field on Custom Setting is populated & we're bypassing Triggers
            if (String.isNotEmpty(bypassLogic.Objects_to_Bypass__c) && bypassLogic.Bypass_Triggers__c == true)
            {
                if (bypassLogic.Objects_to_Bypass__c.contains(objectName) 
                    || 
                    bypassLogic.Objects_to_Bypass__c.equalsIgnoreCase(Constants.CHAR_ALL)
                   )
                {
                    bypassTrigger = true;
                }
            }
        }
        return bypassTrigger;
    }
    
    public static String parseNull(String strValue) 
    {
        if(String.isNotBlank(strValue)) 
        {
            return strValue;
        }
        return Constants.CHAR_BLANK;
    }
    
    // Going through Salesforce Object and associate Object's name with its ID prefix
    public static String initSalesforceIdPrefix()
    {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        String objectDetails = Constants.CHAR_BLANK;
        for(String sObj : Schema.getGlobalDescribe().keySet()){
            Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
            String tempName = r.getName();
            String tempPrefix = r.getKeyPrefix();
            objectDetails += 'Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']' + ' ## ';
        }
        return objectDetails;
    }
    
    // Going through Salesforce Object and associate Object's name with its ID prefix
    public static String initSalesforceIdPrefixInIdealWay()
    {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        String objectDetails = Constants.CHAR_BLANK;
        for(String sObj : Schema.getGlobalDescribe().keySet()){
            Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
            String tempName = r.getName();
            String tempPrefix = r.getKeyPrefix();
            objectDetails += 'Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']' + ' ## ';
        }
        return objectDetails;
    }
    
    public static Schema.SObjectType getObjectTypeOnBasisOfIdValue(Id recordId) 
    {
        return recordId.getSobjectType();
    }
    
    public static String getSobjectAPIName(Schema.SObjectType sObjType) 
    {
        String sObjectName = Constants.CHAR_BLANK;
        
        if(sObjType != null) 
        {
            Schema.DescribeSobjectResult objectDescribe = sObjType.getDescribe();
            if(objectDescribe != null) 
            {
                sObjectName = objectDescribe.getName();  
            }
        }
        return sObjectName;
    }
    
    public static String getSobjectLabel(Schema.SObjectType sObjType) 
    {
        String sObjectLabel = Constants.CHAR_BLANK;
        if(sObjType != null) 
        {
            Schema.DescribeSobjectResult objectDescribe = sObjType.getDescribe();
            if(objectDescribe != null) 
            {
                sObjectLabel = objectDescribe.getLabel();
            }
        }
        return sObjectLabel;
    }
    
    public static Schema.DescribeSObjectResult getObjectDescribeOnBasisOfObjectName(
        String objName
    ) 
    {
        if (objName == null || String.isEmpty(objName))
            return null;
        
        if (
            Type.forName(objName) != null &&
            ((SObject) Type.forName(objName).newInstance()) != null
        ) 
        {
            return ((SObject) Type.forName(objName).newInstance())
                .getSObjectType()
                .getDescribe();
        }
        return null;
    }
    
    public static SObject getObjectOnBasisOfObjectName(String objName) 
    {
        if (objName == null || String.isEmpty(objName))
            return null;
        return ((SObject) Type.forName(objName).newInstance());
    }
    
    public static Map<String, Schema.SObjectField> getFieldsMap(String objName) 
    {
        if (objName == null || String.isEmpty(objName)) 
        {
            return null;
        }
        Schema.DescribeSObjectResult objDescribe = Utilities.getObjectDescribeOnBasisOfObjectName(
            objName
        );
        if (objDescribe != null) 
        {
            return objDescribe.fields.getMap();
        }
        return null;
    }
    
    public static Boolean getObjectIsAccessible(String objectName) 
    {
        if (objectName == null || String.isEmpty(objectName))
            return null;
        return ((sObject)Type.forName(objectName).newInstance()).getSObjectType().getDescribe().isAccessible();    
    }
    
    public static Boolean getFieldIsAccessible(String objectName, String fieldName) 
    {
        if (String.isBlank(objectName))
            return false;
        
        if (String.isBlank(fieldName))
            return false;
        
        if(
            ((sObject)Type.forName(objectName).newInstance()) != null
            && ((sObject)Type.forName(objectName).newInstance()).getSObjectType() != null
            && ((sObject)Type.forName(objectName).newInstance()).getSObjectType().getDescribe() != null
        ) 
        {
            if(((sObject)Type.forName(objectName).newInstance()).getSObjectType().getDescribe().isAccessible()) 
            {
                Map<String, Schema.SObjectField> fieldsMap = Utilities.getFieldsMap(objectName);
                if(fieldsMap != null && fieldsMap.values().size() > 0) 
                {
                    if(fieldsMap.get(fieldName) != null) 
                    {
                        DescribeFieldResult fieldDescribe = fieldsMap.get(fieldName).getDescribe();
                        return fieldDescribe.isAccessible();         
                    }
                } 
            }      
        }
        return false;
    }
    
    public static Schema.DescribeFieldResult getFieldDescribeResult(
        Schema.SObjectType objectType,
        Schema.FieldSetMember member
    ) 
    {
        String fieldPath = member.getFieldPath();
        return getFieldDescribeResult(objectType, fieldPath);
    }
    
    private static String getLookupName(String crossObjectReference) 
    {
        return crossObjectReference.endsWith(Constants.CHAR_DOUBLE_UNDERSCORE_R)
            ? crossObjectReference.replace(
                Constants.CHAR_DOUBLE_UNDERSCORE_R,
                Constants.CHAR_DOUBLE_UNDERSCORE_C
            )
            : crossObjectReference + Constants.ID_FIELD_NAME;
    }
    
    public static List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
    {
        if(String.isNotBlank(fieldSetName) && String.isNotBlank(ObjectName)) 
        {
            Schema.SObjectType SObjectTypeObj = Utilities.getObjectTypeOnBasisOfObjectName(ObjectName);
            Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
            Map<String, Schema.FieldSet> mapOfFieldSetsForObj = DescribeSObjectResultObj.FieldSets.getMap();
            if(mapOfFieldSetsForObj != null) 
            {
                Schema.FieldSet fieldSetObj = mapOfFieldSetsForObj.get(fieldSetName);
                if(fieldSetObj != null) 
                {
                    return fieldSetObj.getFields();    
                }        
            }
        }
        return new List<Schema.FieldSetMember>();    
    }
    
    public static String buildSOQLFieldsLiteralForTheFieldSet(List<Schema.FieldSetMember> fieldSetFieldsDetails) 
    {
        String queryFieldsLiteral = Constants.CHAR_BLANK;
        
        if(fieldSetFieldsDetails != null) 
        {
            for(Schema.FieldSetMember f : fieldSetFieldsDetails) 
            {
                queryFieldsLiteral += f.getFieldPath() + ', ';
            }
        }
        return queryFieldsLiteral;
    }
    
    private static Map<String, Schema.DescribeFieldResult> fieldDescribeResultCache = new Map<String, Schema.DescribeFieldResult>();
    public static Schema.DescribeFieldResult getFieldDescribeResult(
        Schema.SObjectType objectType,
        String fieldPath
    ) 
    {
        Schema.DescribeSobjectResult objectDescribe = objectType.getDescribe();
        String key = objectDescribe.getName() + fieldPath;
        Schema.DescribeFieldResult value = fieldDescribeResultCache.get(key);
        
        if (value == null) 
        {
            List<String> path = fieldPath.split('\\.');
            Schema.SObjectType type = objectType;
            
            if(pkgPrefix == null)
            {
                pkgPrefix = Utilities.getPackagePrefix();
            }
            
            while (path.size() > 1) 
            {
                String lookupName = getLookupName(path.remove(0));
                Schema.DescribeFieldResult describe = null;
                try 
                {
                    describe = type.getDescribe()
                        .fields.getMap()
                        .get(lookupName)
                        .getDescribe();
                } catch (Exception e) 
                {
                    describe = type.getDescribe()
                        .fields.getMap()
                        .get(pkgPrefix + lookupName)
                        .getDescribe();
                }
                type = describe.getReferenceTo()[0];
            }
            
            Map<String, Schema.SObjectField> objectFields = type.getDescribe().fields.getMap();
            Schema.SObjectField objectField = objectFields.get(path[0]);
            
            if (objectField == null) 
            {
                if(String.isNotBlank(pkgPrefix)) 
                {
                    objectField = objectFields.get(pkgPrefix + path[0]);    
                }
                else 
                {
                    objectField = objectFields.get(path[0]);
                }
            }
            if(objectField != null) 
            {
                value = objectField.getDescribe();   
                fieldDescribeResultCache.put(key, value);
            }
        }
        return value;
    }
    
    //Method to validate a string for a validate salesforce ID value
    public static Boolean isaValidateSalesforceID(String idString) 
    {
        Boolean isAValidateIDValue = false;
        
        if(String.isNotBlank(idString)) 
        {
            if(idString instanceOf Id) 
            {
                isAValidateIDValue = true;     
            }    
        }
        return isAValidateIDValue;
    }
    
    public static List<String> getListOfValuesForCommaSeperateString(String stringVal) 
    {
        List<String> listOfStrings = new List<String>();
        
        if(String.isNotBlank(stringVal)) 
        {
            listOfStrings = stringVal.split(Constants.CHAR_COMMA);    
        }
        return listOfStrings;
    }
    
    public static SOQLQueryWrapper buildSOQLQuery(String objectName, String fieldsName, 
                                                  Integer limitValue, Boolean enableWithSecurityEnforced,
                                                  Boolean addPrefix, String whereClause,
                                                  String orderBy, String nullFirstOrLastString,
                                                  String offset
                                                 ) 
    {
        SOQLQueryWrapper sOQLQueryWrapper = new SOQLQueryWrapper();
        
        if(String.isNotBlank(objectName) && String.isNotBlank(fieldsName)) 
        {
            String query = Constants.SOQL_STRING_SELECT_KEYWORD;
            String queryTempString = Constants.CHAR_BLANK;
            Set<String> fieldsAlreadyInQuery = new Set<String>();
            List<GenericTableHeaderWrapper> columnsWrapper = new List<GenericTableHeaderWrapper>();
            
            //Map of fields Details
			Map<String, Schema.SObjectField> fieldsMap = Utilities.getFieldsMap(objectName);
            
            if(pkgPrefix == null)
            {
                pkgPrefix = Utilities.getPackagePrefix();
            }
            
            //Processing SOQL String fields
            if (String.isNotBlank(fieldsName)) 
            {
                String actualFieldName = Constants.CHAR_BLANK;
                //If we have more than one field mentioned in the comma seperated fashion
                if(fieldsName.trim().split(Constants.CHAR_COMMA).size() > 0) 
                {
                    columnsWrapper = new List<GenericTableHeaderWrapper>();
                    for (String fieldName : fieldsName.trim().split(Constants.CHAR_COMMA)) 
                    {
                        if(fieldName != null) 
                        {
                            actualFieldName = fieldName;
                            fieldName = fieldName.trim().toLowerCase();
                            
                            if (
                                String.isNotBlank(pkgPrefix) &&
                                fieldName.endswith(Constants.CHAR_DOUBLE_UNDERSCORE_C) &&
                                !fieldName.startsWith(pkgPrefix) &&
                                addPrefix
                            ) 
                            {
                                fieldName = pkgPrefix + fieldName;
                            }
                            
                            if(!fieldsAlreadyInQuery.contains(fieldName) && 
                               (
                                   Utilities.getFieldIsAccessible(objectName, fieldName)
                                   ||
                                   enableWithSecurityEnforced
                               )) 
                            {
                                queryTempString += fieldName + Constants.CHAR_COMMA;
                                fieldsAlreadyInQuery.add(fieldName);
                            }
                        }
                        
                        if(fieldsMap != null && fieldsMap.values().size() > 0) 
                		{
                            if(String.isNotBlank(fieldName) 
                               && fieldsMap.containsKey(fieldName.trim().toLowerCase()) != null
                              ) 
                            {
                                GenericTableHeaderWrapper genericTableHeaderWrap = new GenericTableHeaderWrapper(); 
                                genericTableHeaderWrap.fieldLabel = fieldsMap.get(fieldName.trim().toLowerCase()).getDescribe().getLabel();
                                genericTableHeaderWrap.fieldName = actualFieldName;
                                genericTableHeaderWrap.fieldType = String.valueOf(fieldsMap.get(fieldName.trim().toLowerCase()).getDescribe().getType());
                                columnsWrapper.add(genericTableHeaderWrap);        
                            }
                        }    
                    }  
                }
                //If only one field is mentioned
                else 
                {
                    columnsWrapper = new List<GenericTableHeaderWrapper>();
                    actualFieldName = fieldsName;
                    
                    fieldsName = fieldsName.trim().toLowerCase();
                    
                    if (
                        String.isNotBlank(pkgPrefix) &&
                        fieldsName.endswith(Constants.CHAR_DOUBLE_UNDERSCORE_C) &&
                        !fieldsName.startsWith(pkgPrefix) &&
                        addPrefix
                    ) 
                    {
                        fieldsName = pkgPrefix + fieldsName;
                    }
                    
                    if(!fieldsAlreadyInQuery.contains(fieldsName) && 
                       (
                           Utilities.getFieldIsAccessible(objectName, fieldsName)
                           ||
                           enableWithSecurityEnforced
                       )) 
                    {
                        queryTempString += fieldsName +  Constants.CHAR_COMMA;
                        fieldsAlreadyInQuery.add(fieldsName);
                    }
                    
                    if(fieldsMap != null && fieldsMap.values().size() > 0) 
                    {
                        if(String.isNotBlank(fieldsName) 
                           && fieldsMap.containsKey(fieldsName.trim().toLowerCase()) != null
                          ) 
                        {
                            GenericTableHeaderWrapper genericTableHeaderWrapper = new GenericTableHeaderWrapper(); 
                            genericTableHeaderWrapper.fieldLabel = fieldsMap.get(fieldsName.trim().toLowerCase()).getDescribe().getLabel();
                            genericTableHeaderWrapper.fieldName = actualFieldName;
                            genericTableHeaderWrapper.fieldType = String.valueOf(fieldsMap.get(fieldsName.trim().toLowerCase()).getDescribe().getType());
                            columnsWrapper.add(genericTableHeaderWrapper);
                        }
                    }
                }
            }
            
            //Eliminating Duplicate field names (if any)
            String processedSOQLQuery = Constants.CHAR_BLANK;
            Set<String> setOfUniqueFieldsName = new Set<String>();
            
            if(String.isNotBlank(queryTempString) && queryTempString.trim().split(Constants.CHAR_COMMA).size() > 0) 
            {
                for(String fieldNameStr : queryTempString.trim().split(Constants.CHAR_COMMA)) 
                {
                    if(!setOfUniqueFieldsName.contains(fieldNameStr.trim().toLowerCase())) 
                    {
                        processedSOQLQuery += fieldNameStr.trim().toLowerCase() + Constants.CHAR_COMMA;
                        setOfUniqueFieldsName.add(fieldNameStr);
                    }    
                }            
            }
            else 
            {
                processedSOQLQuery = queryTempString;    
            }
            
            if(String.isNotBlank(processedSOQLQuery)) 
            {
                processedSOQLQuery = processedSOQLQuery.removeEnd(Constants.CHAR_COMMA);
                query += processedSOQLQuery;
            }
            
            query += Constants.CHAR_BLANK_SPACE + Constants.SOQL_STRING_FROM_KEYWORD + objectName;
            
            
            if (String.isNotBlank(whereClause)) 
            {
                query += Constants.CHAR_BLANK_SPACE + whereClause;
            }
            
            if (enableWithSecurityEnforced) 
            {
                query +=
                    Constants.CHAR_BLANK_SPACE +
                    Constants.SOQL_STRING_WITH_SECURITY_ENFORCED_KEYWORD;
            }
            
            if (String.isNotBlank(orderBy)) 
            {
                query += Constants.CHAR_BLANK_SPACE + orderBy;
            }
            
            if (String.isNotBlank(nullFirstOrLastString)) 
            {
                query += Constants.CHAR_BLANK_SPACE + nullFirstOrLastString;
            }
            
            if (limitValue != null) 
            {
                query += Constants.SOQL_STRING_LIMIT_KEYWORD + Constants.CHAR_BLANK_SPACE + String.valueOf(limitValue);
            }
            
            if (String.isNotBlank(offset)) 
            {
                query += Constants.CHAR_BLANK_SPACE + offset;
            }
            sOQLQueryWrapper.sOQLQuery = query;  
            sOQLQueryWrapper.listOfGenericTableHeaderWrapper = columnsWrapper;
        }
        return sOQLQueryWrapper;
    }
}