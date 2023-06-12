/*
 * Purpose      : Response Wrapper Class 
 * 
 * Created By   : Nikunj Jain
 * 
 * Created Date : 26-05-2023
 * 
 * Version      : V_0.1
 * 
 * Story        : 
 */
public class ResponseWrapper {
    @AuraEnabled public String msg;
    @AuraEnabled public Boolean isSuccess;
    @AuraEnabled public object body;
    @AuraEnabled public String type;
    
    public void setError(String errorMsg)
    {
        this.isSuccess = false;
        this.msg = errorMsg;
        this.body = null;
    }
    public void setBody(object body)
    {
        this.isSuccess = true;
        this.body = body;
    }
    public ResponseWrapper()
    {
        this.isSuccess = true;
    }
    

}