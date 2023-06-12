/**
 * Purpose     : class of Practice Assessment Questions
 * 
 * Created By  : Nikunj jain
 * 
 * Create Date : 20-03-2023
 * 
 * Resion Log  :
 *
*/
public class AssessmentHerokuApp {
    
    @future(callout=true)
    public static void heroKuAppintegration()
    {
        Http http= new Http();
        
        HttpRequest request= new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        
        httpResponse response= http.send(request);
        
        if(response.getStatusCode() == 200 )
        {
            List<User> listOfuser =[SELECT ID, Heroku_App_Response__c FROM User WHERE Id =: System.Label.TEARCHER_USER_RECORD_ID AND IsActive=true];
            
            if(!listOfuser.isEmpty())
            {
                Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                
                List<Object> value=(List<object>)result.get('animals');
                
                String finallResult='';
                for(Object l:value)
                {
                    finallResult = l +'  '+ finallResult;
                }
                listOfuser[0].Heroku_App_Response__c=finallResult;
                
                
            }
            update listOfuser;
        }
        
    }

}