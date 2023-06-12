/*
 * Purpose      : Find And Populate Number Of Student And Number Of Classes By The Trigger
 * 
 * Created By   : Nikunj jain
 * 
 * Created Date : 27/03/2023
 * 
 * Version      : V_0.1
*/

public Without sharing  class StudentTriggerHandler {
    
    public static void countNoOfStudentsDetails ( List<Student__c> Students, Map<Id, Student__c> mapOfOldStudent)
    {
        Set<Id> setOfParentSchools = new Set<Id>();
        
      
        for(Student__c std : Students != null ? Students : mapOfOldStudent.values())
        {
            if(std.School__c != null)
            {
                setOfParentSchools.add(std.School__c);
            }
        }
        
        List<School__c>listOfSchool=[SELECT ID, Name FROM School__c WHERE ID IN : setOfParentSchools];
        
        
                
        if(listOfSchool.size() > 0)
        {
            updateNoOfStudentsDetails(listOfSchool[0].Name);
        }
        
    }
    
    
    public static void updateNoOfStudentsDetails(String schoolName)
    {
        if(String.isNotBlank(schoolName))
        {  
            Map<Id,School__c> mapOfSchools = new Map<Id, School__c>();
            
            for(School__c schl : [SELECT ID, No_Of_Student__c
                                 FROM School__c
                                 WHERE Name =: schoolName.trim()])
            {
                mapOfSchools.put(schl.Id, schl);
            }
            
            if(mapOfSchools.values() != null && mapOfSchools.values().size()>0)
            {
               CountManagerOld.doCalculationsForNoOfStudents(mapOfSchools);
            }
            else
            {
                System.debug(System.LABEL.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);
            }
            
        }
        else
        {
            System.debug(System.LABEL.ERROR_MSG_SCHOOL_DETAILS_MISSING);
        }
    }
     
    
}