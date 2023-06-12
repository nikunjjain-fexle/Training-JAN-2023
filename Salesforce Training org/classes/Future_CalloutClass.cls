/*
  Purpose      : Callouts
  
  Created By   : Nikunj Jain

  Created Date : 13-04-2023

  Version      : V_0.1

  Story        : 
 
*/

public class Future_CalloutClass {
    
    @future(callout=true)
    public static void makeCallout()
    {
     
        HttpRequest  request=new HttpRequest ();
        String endPoint='https://th-apex-http-callout.herokuapp.com/animals';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        //HttpResponse response = new HTTP().send(request);
        Http h=new Http();
        HttpResponse  res=h.send(request);
         System.debug('@@@@@@  response'+ res.getBody());
        System.debug('@@@@@@  response'+ res);
        
    }

}