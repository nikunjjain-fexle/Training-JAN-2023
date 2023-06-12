/*
 * Purpose       : Write Future Mathod For SchoolTrigger Handler object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 11-04-2023
 * 
 * Version       : V_0.1
*/

// End pint not Be in hard Code
// if you are try to hit salesforce that case  u need Make Remote side Setting
// Get Constant make constant HTTP_CALLOUT_OPERATION_GET
// sccess code = 200;  HTTP_CALLOUT_SUCCESS_CODE
// 
public Without Sharing class HerokuAppResponseManager {
   
    /*@future(Callout=true)
    public static void  makeCallOutToherokuAndUpdateUsers(Set<Id>schoolIds)
    {
        if(schoolIds != null && schoolIds.size() > 0)
        {
            HerokuAppResponseManager.makeHerokuAppCallOutAndUpdateUser(schoolIds);
        }
    }*/
    
    
    @future(Callout=true)
    public static void makeCallOutHerokuUpdateUser(Set<Id>schoolIds)
    {
        if(schoolIds != null && schoolIds.size() > 0)
        {
            Http http=new Http();
            HttpRequest request= new  HttpRequest();
            request.setEndpoint(System.Label.ENDPOINT_HEROKU_APPLICATION);
            request.setMethod('GET');
            HttpResponse  response=http.send(request); 
            
            if(response.getStatusCode()==200)
            {
                List<User>integrationUserDetails=[SELECT Id, Heroku_App_Response__c FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
                if(integrationUserDetails.size()>0)
                {
                    if(response.getBody() !=null){
                        String TempResponse=' ';
                        for(Id SchId : schoolIds)
                        {
                            TempResponse+=schId+' ';
                        }
                        TempResponse+=String.valueOf(response.getBody());

                        integrationUserDetails[0].Heroku_App_Response__c=TempResponse; 
                    }
                    Utilities.BypassAllTriggers=true;
                    update integrationUserDetails;
                    Utilities.BypassAllTriggers=false;
                }
            }
            
        }
    }
    
    public static void makeHerokuAppCallOutAndUpdateUser(Set<Id>schoolIds)
    {
         if(schoolIds != null && schoolIds.size() > 0)
        {
            Http http=new Http();
            HttpRequest request= new  HttpRequest();
            request.setEndpoint(System.Label.ENDPOINT_HEROKU_APPLICATION);
            request.setMethod('GET');
            HttpResponse  response=http.send(request); 
            
            if(response.getStatusCode()==200)
            {
                List<User>integrationUserDetails=[SELECT Id, Heroku_App_Response__c FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
                if(integrationUserDetails.size()>0)
                {
                    if(response.getBody() !=null){
                        String TempResponse=' ';
                        for(Id SchId : schoolIds)
                        {
                            TempResponse+=schId+' ';
                        }
                        TempResponse+=String.valueOf(response.getBody());

                        integrationUserDetails[0].Heroku_App_Response__c=TempResponse; 
                    }
                    Utilities.BypassAllTriggers=true;
                    update integrationUserDetails;
                    Utilities.BypassAllTriggers=false;
                }
            }
            
        }
    }

}