/**
*
*  Purpose          :   Controller Class
*
*  Created Date     :   19-05-2023
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public class ClassController {
    @AuraEnabled(cacheable = false)
    public static List<Class__c> getClassName(String SchoolId) 
    {
        
        try
        {
            if(String.isNotBlank(SchoolId))
            {
                return [SELECT Id,Name,Active__c,Board__c,CreatedById,LastModifiedById,(SELECT Id, Name, School_Name__c,Active_Student__c,Father_Name__c FROM Students__r) FROM Class__c WHERE School__c =:SchoolId];
                
            }
            return null;
        }
        catch(Exception e)
        {
            System.debug('Error  '+e.getMessage());
        }
        return null;
    }
    
    @AuraEnabled(cacheable = false)
    public static List<Student__c> getStudentDetails(String SchoolId) 
    {
        
        try
        {
            if(String.isNotBlank(SchoolId))
            {
                return [SELECT Name ,Custom_School_Id__c FROM Student__c WHERE Custom_School_Id__c =:SchoolId];
                
            }
            return null;
        }
        catch(Exception e)
        {
            System.debug('Error  '+e.getMessage());
        }
        return null;
    }
    
    @AuraEnabled
    public static boolean massDeleteRec(List<Student__c> listofStd)
    {
        System.debug('Yes mass delete');
        delete listofStd;
        return true;
    }
    
    @AuraEnabled
    public static boolean massUpdateRec(List<Student__c> listofStd)
    {
        System.debug('Yes mass delete');
        update listofStd;
        return true;
    }
    // This Class will be Execute On delete Event
    @AuraEnabled(cacheable=false)
    public static void updateStudents (List<Student__c> mapOfStudents )
    {
        System.debug('Yes in Side Update Apex Class'+mapOfStudents);
        
        
        
       
        if(!mapOfStudents.isEmpty())
        {
            List<Student__c> finalUpdate= new List<Student__c> ();
            for(Student__c up :mapOfStudents)
            {
                Student__c std = new Student__c();
                std.Id=up.Id;
                std.Father_Name__c=up.Father_Name__c;
                finalUpdate.add(std);
            }
            if(!finalUpdate.isEmpty())
            {
                update finalUpdate;
            }
        }
        
        
    }
}