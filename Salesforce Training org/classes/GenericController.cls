public class GenericController {
    @AuraEnabled(cacheable = false)
    public static List<sObject> doQuery(String objectName, String fielddName, Integer LimitValue) 
    {
        try 
        {
            throw new CustomException('@@@objectName'+objectName+'  '+fielddName+'  '+LimitValue);
        } 
        catch (Exception ex) {
            return null;
        }
    }
}