/**
 * Purpose     : Practice
 * 
 * Created By  : Nikunj jain
 * 
 * Create Date : 20-03-2023
 * 
 * Resion Log  :
 *
*/
public Without sharing class AssessmentStudentHandler 
{
    public static void insertionAndDeletionOfStudent(List<Student__c>listOfStudent, Map<Id,Student__c>mapOfStudent)
    {
     
        if(listOfStudent != null || mapOfStudent != null)
        {
            Set<id>setOfParentId = new Set<Id>();
            
            for(Student__c std:listOfStudent != null ? listOfStudent : mapOfStudent.Values())
            {
                    setOfParentId.add(std.School__c);
            }
            
           
            
            if(setOfParentId != null )
            {
                List<School__c>listOfSchoolName=[SELECT Id, Name  FROM School__c WHERE Id =:setOfParentId];
               
                if(listOfSchoolName!= null && listOfSchoolName.size() > 0)
                {
                 
                    AssesmentPractice.NoOfStudent(listOfSchoolName[0].Name);
                }
            }
        }
    }
     
        
}