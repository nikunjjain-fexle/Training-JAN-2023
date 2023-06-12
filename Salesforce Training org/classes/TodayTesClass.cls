public class TodayTesClass {
    
    public static void newMethod(String ObjectApiName)
    {
        if(ObjectApiName!= null)
        {
            Type objectType = Type.forName(ObjectApiName);
            
            if(objectType != null)
            {
                Schema.DescribeSObjectResult objectResult = ((sObject)objectType.newInstance()).getSObjectType().getDescribe();
                
                Map<String,Schema.SObjectField>  mapObjectField = objectResult.Fields.getMap();
                
                for(String s : mapObjectField.KeySet())
                {
                    Schema.DescribeFieldResult fieldResult = mapObjectField.get(s).getDescribe();
                    
                    if(!fieldResult.isNillable())
                    {
                        System.debug('------->  Field Name:  '+s+'----------Require Field ---->'+!fieldResult.isNillable());
                    }
                    else
                    {
                        System.debug('------->  Field Name: '+s+'----------Not Require Field ---->'+!fieldResult.isNillable());
                    }
                }
            }
            else
            {
                System.debug('object Not Found !');
            }
        }
        else
        {
            System.debug('Please Enter Valid API Name');
        }
    }
    public static void  printAllFieldAPIsWithRequired(String objectAPIName) {
        Schema.DescribeSObjectResult objDescribe = Schema.describeSObjects(new List<String>{ objectAPIName })[0];
        
        if(objDescribe == null) {
            System.debug('Object not found!');
            return;
        }
        
        Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
        for(String fieldName : fieldMap.keySet()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
            System.debug(fieldDescribe.getName() + ' (Required: ' + !fieldDescribe.isNillable() + ')');
        }
    }
    public Static void printAllFieldAPIs(String objectAPIName) {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objType = schemaMap.get(objectAPIName);
        
        if(objType == null) {
            System.debug('Object not found!');
            return;
        }
        
        Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();
        for(String fieldName : fieldMap.keySet()) {
            System.debug(fieldMap.get(fieldName).getDescribe().getName());
        }
    }

}