/*
 * Purpose      : Get Query for Custom Report
 * 
 * Created By   : Nikunj Jain
 * 
 * Created Date : 20-05-2023
 * 
 * Version      : V_0.1
 * 
 * Story        : 
*/

public class GetDetailToQuery {
    
     @AuraEnabled(cacheable = true)
    public static List<sObject> getOneObjectRecords(String objectApiName, String fieldApiName, String recordsLimit) 
    {
        
        try
        {
            if(String.isNotBlank(objectApiName) && String.isNotBlank(fieldApiName) && recordsLimit!= null)
            {
              
                String records='SELECT '+fieldApiName+' FROM '+objectApiName+' LIMIT '+recordsLimit;
                System.debug('record--->'+records);
                
                list<sobject> queryResult= Database.query(records);
                System.debug('QueryResult  =>'+queryResult);
                return queryResult;
                
            }
            return null;
        }
        catch(Exception e)
        {
            System.debug('Error  '+e.getMessage());
        }
        return null;
    }
    
    @AuraEnabled(cacheable=false)
    public static List<sObject> getObjectDetailsOfOnKeyPress(String searchInput , String objectApiName) {    
        List < sObject > listOfResult = new List < sObject > ();
        String  searchKeyWithLike = '%' + searchInput + '%';
        String sQuery = 'Select Id,Name From ' + objectApiName + ' Where Name Like : searchKeyWithLike order by createdDate DESC LIMIT 5';
        System.debug('sQuery->'+sQuery);
        for (sObject obj: database.query(sQuery)) {
            listOfResult.add(obj);
        }
        return listOfResult;
    }
    
    
    @AuraEnabled(cacheable = true)
    public static List<sObject> getOneObjectRecordsDetails(String dynamicQuery) 
    {
        
        try
        {
            if(String.isNotBlank(dynamicQuery))
            {
              
                
                System.debug('dynamicQuery--->'+dynamicQuery);
                
                list<sObject> queryResult= Database.query(dynamicQuery);
                System.debug('QueryResult  =>'+queryResult);
                return queryResult;
                
            }
            return null;
        }
        catch(Exception e)
        {
            System.debug('Error  '+e.getMessage());
        }
        return null;
    }

}