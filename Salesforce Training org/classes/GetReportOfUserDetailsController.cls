/*
 * Purpose      : Get Create Custom Report On User Input Controller Class
 * 
 * Created By   : Nikunj Jain
 * 
 * Created Date : 28-05-2023
 * 
 * Version      : V_0.1
 * 
 * Story        : 
 * 
 */


public class GetReportOfUserDetailsController {
    
    public class AllobjectAndFieldsAndDataTypes
    {
        @AuraEnabled
        public List<sObject> objectDetails{get; set;}
        @AuraEnabled
        public List<String> sObjectFieldsList{get; set;}
        @AuraEnabled
        public List<String> sizeOfStudents{get; set;}
    }
    
     public static ResponseWrapper getALLObjectAndFieldsAndDataTypeDetails()
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            /*
            Schema.DescribeSObjectResult r = Account.sObjectType.getDescribe();
            
            List<String>apiNames =  new list<String>();
            
            for(string apiName : r.fields.getMap().keySet()){
                
                apiNames.add(apiName);
                
            }*/
            
            
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
            Set<String> standardObjects = new Set<String>();
            Set<String> customObjects = new Set<String>();
            for(Schema.SObjectType d : gd.values())
            {
                Schema.DescribeSObjectResult ds = d.getDescribe();
                
                if(ds.isCustom() == false && ds.getRecordTypeInfos().size() > 0)
                {
                    customObjects.add(ds.getName());
                    //standardObjects.add(ds.getName());
                }
                else if(ds.isCustom())
                {
                    customObjects.add(ds.getName());
                }
                    
            }
            List<String> sortedNames = new List<String>(customObjects);
            sortedNames.sort();
            
            rw.setBody(sortedNames);
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    // This Method Will be Return All Object to Database 
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getDetails()
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            //List<EntityDefinition> objectDetails = [SELECT  QualifiedApiName, Label FROM EntityDefinition WHERE IsCustomizable = true];
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
            Set<String> standardObjects = new Set<String>();
            Set<String> customObjects = new Set<String>();
            for(Schema.SObjectType d : gd.values())
            {
                Schema.DescribeSObjectResult ds = d.getDescribe();
                if(!ds.isCreateable())
                    continue;
                if(ds.isCustom() == false && ds.getRecordTypeInfos().size() > 0)
                {
                    customObjects.add(ds.getName());
                    //standardObjects.add(ds.getName());
                }
                else if(ds.isCustom())
                {
                    customObjects.add(ds.getName());
                }
                    
            }
            List<String> sortedNames = new List<String>(customObjects);
            sortedNames.sort();
            
            rw.setBody(sortedNames);
            
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    // This Method Will be Return All Field Of Particular Object
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getFieldsDetails(String objectName)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(objectName))
            {
                // Get Object Sobject Type
                Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
                
                // Get All Object Field
                Map<String, Schema.SObjectField> objectsAllField = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
                
                List<String> sObjectDetailsList = new List<String>();
                
                for(String s : objectsAllField.keySet()){
                    sObjectDetailsList.add(String.valueOf(objectsAllField.get(s)));                    
                }
                rw.setBody(sObjectDetailsList);
                                
            }
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    // This Method Will be Return  Field Data type
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getFieldDataTypeDetails(String objectName, String selectedFields)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            
            String fieldType;
            if(String.isNotBlank(objectName) && String.isNotBlank(selectedFields))
            {
                // Field Data type
                /*
                fieldType=[SELECT DataType FROM FieldDefinition WHERE EntityDefinitionId=:objectName AND QualifiedApiName=:selectedFields LIMIT 1].DataType;
                System.debug('Field datatype ---'+fieldType);*/
                
                SObjectType r = ((SObject)(Type.forName('Schema.'+objectName).newInstance())).getSObjectType();
                DescribeSObjectResult d = r.getDescribe();
                Schema.DisplayType DisplayTypefieldType=(d.fields.getMap().get(selectedFields).getDescribe().getType());
                fieldType=DisplayTypefieldType.name();
                
            }
            
            rw.setBody(fieldType);
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
     // This Method Will be Return  user input Records
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getRecordOnUserInput(List<Map<String, Object>>dynamicFieldsQuery,String conditions , String selectedField ,String selectedObjectName, String recordLimit, List<String> customeConditions)
    {           
        System.debug('dynamicFieldsQuery  ---'+dynamicFieldsQuery);
        
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(dynamicFieldsQuery!= null || String.isNotBlank(selectedObjectName) && String.isNotBlank(selectedField))
            {
                String selectedFieldList ='';
                String finalQuery='';
                String dyanmicQuery='';
                 String percentage='';
                List<String> fieldList = (List<String>) JSON.deserializeStrict(selectedField, List<String>.class);
                for (String field : fieldList) {
                    
                    selectedFieldList = field +','+selectedFieldList;   
                }
                selectedFieldList= selectedFieldList.removeEnd(',');
               
                if(!customeConditions.isEmpty())
                {
                    System.debug('in side Custom Conditions');
                    String startCurliBrackets='';
                    String CloseCurliBrackets='';
                    for(String c:customeConditions)
                    {
                        System.debug('Custom seperate ->'+c);
                        String lowercaseStr = c.toLowerCase();
                        String customConditions='';
                        
                        if (lowercaseStr.equals('or') || lowercaseStr.equals('and')){
                            customConditions = c;
                            
                        }
          
                        else if((c=='('))
                        {
                            startCurliBrackets=c;
                            System.debug('startCurliBrackets---1->'+startCurliBrackets);
                        }
                        else if((c==')'))
                        {
                            startCurliBrackets=c;
                             System.debug('CloseCurliBrackets--2-->'+CloseCurliBrackets);
                        }
                        else
                        {
                            System.debug('custom condition else part');
                            Integer index = Integer.valueOf(c) - 1;
                            for (Map<String, Object> data : dynamicFieldsQuery)
                            {
                                if(index == Integer.valueOf(data.get('index')))
                                {
                                    String field = (String) data.get('field');

                                    String operator = (String) data.get('operator');
                                    if(operator =='LIKE')
                                    {
                                        percentage='%';
                                    }
                                   
                                    String value = string.valueOf(data.get('value'));
                                    
                                    String dataType=(String) data.get('dataType');
                                    System.debug('');
                                    if(dataType=='CURRENCY')
                                    {
                                        finalQuery += field +' '+ operator +' '+ value;
                                    }
                                    else if(dataType=='CHECKBOX')
                                    {
                                        finalQuery +=field +' '+ operator +' '+ value;
                                    }
                                    else if(dataType=='PICKLIST')
                                    {
                                        finalQuery += field +' '+ operator +' '+ '\''+value+'\'';
                                    }
                                    else if(dataType=='DATETIME')
                                    {
                                        finalQuery += field +' '+ operator +' '+value+' ';
                                    }
                                    else if(dataType=='DATE')
                                    {
                                        finalQuery += field +' '+ operator +' '+value+' ';
                                    }
                                    else if(dataType=='DOUBLE')
                                    {
                                        finalQuery += field +' '+ operator +' '+value+' ';
                                    }
                                    else
                                    {
                                        finalQuery += field +' '+ operator +' '+ '\''+value+''+percentage+'\'';
                                    }
                                }
                            }
                             startCurliBrackets='';
                             closeCurliBrackets='';
                        }
                        finalQuery+=startCurliBrackets+' '+customConditions+' ';
                        startCurliBrackets='';
                        closeCurliBrackets='';
                        System.debug('==========================================>finalQuery'+finalQuery);
                        
                    }
                    System.debug('finalQuery----------------------------------->'+finalQuery);
                    
                }
                
                for (Map<String, Object> data : dynamicFieldsQuery)
                {
                    if(conditions=='AND')
                    {
                        System.debug(' for loop  first');
                        String field = (String) data.get('field');
                        //System.debug('field---> '+field);
                        
                        String operator = (String) data.get('operator');
                        if(operator =='LIKE')
                        {
                             percentage='%';
                        }
                        //System.debug('operator---> '+operator);
                        
                        String value = string.valueOf(data.get('value'));
                        //System.debug('value---> '+value);
                        
                        String dataType=(String) data.get('dataType');
                        System.debug('dataType--->'+dataType);
                        if(dataType=='CURRENCY')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value+' '+conditions;
                        }
                        else if(dataType=='CHECKBOX')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value+' '+conditions;
                        }
                        else if(dataType=='PICKLIST')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ '\''+value+'\''+' '+conditions;
                        }
                        else if(dataType=='DATETIME')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else if(dataType=='DATE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else if(dataType=='DOUBLE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else
                        {
                            finalQuery += ' '+field +' '+ operator +' '+'\''+value+''+percentage+'\''+' '+conditions;
                        }
                        
                        
                        
                    }
                    
                    else if(conditions=='OR')
                    {
                        System.debug('else if 338');
                        String field = (String) data.get('field');
                        //System.debug('field---> '+field);
                        
                        String operator = (String) data.get('operator');
                        if(operator =='LIKE')
                        {
                             percentage='%';
                        }
                        //System.debug('operator---> '+operator);
                        
                        String value = string.valueOf(data.get('value'));
                        //System.debug('value---> '+value);
                        String dataType=(String) data.get('dataType');
                        if(dataType=='CURRENCY')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value+' '+conditions;
                        }
                        else if(dataType=='CHECKBOX')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value+' '+conditions;
                        }
                        else if(dataType=='PICKLIST')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ '\''+value+'\''+' '+conditions;
                        }
                        else if(dataType=='DATETIME')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else if(dataType=='DATE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else if(dataType=='DOUBLE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value+' '+conditions;
                        }
                        else
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ '\''+value+''+percentage+'\''+' '+conditions;
                        }  
                    }
                    else if(customeConditions.size()==0)
                    {
                        System.debug('else if 379');
                        String field = (String) data.get('field');
                        //System.debug('field---> '+field);
                        
                        String operator = (String) data.get('operator');
                        if(operator =='LIKE')
                        {
                             percentage='%';
                        }
                        //System.debug('operator---> '+operator);
                      
                        String value = string.valueOf(data.get('value'));
                        //System.debug('value---> '+value);
                        System.debug('Before debug');
                        
                        String dataType=(String) data.get('dataType');
                        System.debug('after debug');
                        System.debug('dataType--->'+dataType);
                        if(dataType=='CURRENCY')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value;
                        }
                        else if(dataType=='CHECKBOX')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ value;
                        }
                        else if(dataType=='PICKLIST')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ '\''+value+'\'';
                        }
                        else if(dataType=='DATETIME')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value;
                        }
                        else if(dataType=='DOUBLE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value;
                        }
                        else if(dataType=='DATE')
                        {
                            finalQuery += ' '+field +' '+ operator +' '+value;
                        }
                        else
                        {
                            finalQuery += ' '+field +' '+ operator +' '+ '\''+value+''+percentage+'\'';
                        }  
                    }
                    
                    
                }
                if (finalQuery.endsWith('AND')) {
                    finalQuery=finalQuery.removeEnd('AND');
                }
                else if (finalQuery.endsWith('OR')) {
                    finalQuery=finalQuery.removeEnd('OR');
                }
                
                System.debug('finalQuery  ---> '+finalQuery);
                if(String.isNotBlank(recordLimit) && String.isNotBlank(finalQuery))
                {
                    dyanmicQuery= 'SELECT '+selectedFieldList+' FROM '+selectedObjectName+' WHERE '+finalQuery+' LIMIT '+recordLimit;
                }
                else if(String.isNotBlank(finalQuery))
                {
                    dyanmicQuery= 'SELECT '+selectedFieldList+' FROM '+selectedObjectName+' WHERE '+finalQuery;
                }
                else if(String.isBlank(finalQuery) && String.isNotBlank(recordLimit))
                {
                    dyanmicQuery= 'SELECT '+selectedFieldList+' FROM '+selectedObjectName+' LIMIT '+recordLimit;
                }
                else
                {
                    dyanmicQuery= 'SELECT '+selectedFieldList+' FROM '+selectedObjectName;
                }
                System.debug('dyanmicQuery------------>'+dyanmicQuery);
                
                rw.setBody(Database.query(dyanmicQuery));
            }
                
            
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
        
    
    // This Method Will be Return  user input picklist values
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getPickListValuesIntoList(String objectName, String selectedFields)
    {
        System.debug('objectName----'+objectName+'selectedFields----'+selectedFields);
        ResponseWrapper rw = new ResponseWrapper();
        String fieldName=selectedFields;
        try
        {
            
            Map<String, String> values = new Map<String, String>{};
                
            List<Schema.DescribeSobjectResult> results = Schema.describeSObjects(new List<String>{objectName});
            
            for(Schema.DescribeSobjectResult res : results) {
                for (Schema.PicklistEntry entry : res.fields.getMap().get(fieldName).getDescribe().getPicklistValues()) {
                    if (entry.isActive()) {
                        values.put(entry.getValue(), entry.getLabel());
                    }
                }
            }
            
            rw.setBody(values);
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        
        return rw;
    }
    
}

/*
 // This Method Will be Return All Object to Database 
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getDetails()
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            List<EntityDefinition> objectDetails = [SELECT  QualifiedApiName, Label FROM EntityDefinition WHERE IsCustomizable = true];
            
            rw.setBody(objectDetails);
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    // This Method Will be Return All Field Of Particular Object
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getFieldsDetails(String objectName)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(objectName))
            {
                // Get Object Sobject Type
                Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
                
                // Get All Object Field
                Map<String, Schema.SObjectField> objectsAllField = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
                
                List<String> sObjectDetailsList = new List<String>();
                
                for(String s : objectsAllField.keySet()){
                    sObjectDetailsList.add(String.valueOf(objectsAllField.get(s)));                    
                }
                rw.setBody(sObjectDetailsList);
                                
            }
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    // This Method Will be Return  Field Data type
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getFieldDataTypeDetails(String objectName, String selectedFields)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            System.debug('Field datatype ---'+objectName+'--------------'+selectedFields);
            String fieldType = '';
            if(String.isNotBlank(objectName))
            {
                // Field Data type
                
                fieldType=[SELECT DataType FROM FieldDefinition WHERE EntityDefinitionId=:objectName AND QualifiedApiName=:selectedFields LIMIT 1].DataType;
                System.debug('Field datatype ---'+fieldType);                
            }
            rw.setBody(fieldType);
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
     // This Method Will be Return  user input Records
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getRecordOnUserInput(String dynamicFieldsQuery)
    {
        
       System.debug('result '+dynamicFieldsQuery);
       List<sObject> listOfSobject = Database.query(dynamicFieldsQuery);
       System.debug('result '+listOfSobject);
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(dynamicFieldsQuery))
            {
                 
                rw.setBody(Database.query(dynamicFieldsQuery));
            }
            
            
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
*/