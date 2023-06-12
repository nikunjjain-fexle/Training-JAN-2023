/**
 * Purpose     : Practice
 * 
 * Created By  : Nikunj jain
 * 
 * Create Date :20-03-2023
 * 
 * Resion Log  :
 *
*/
public class AssessmentClassHandler {
    public static void insertionAndDeletionOfClass(List<Class__c>listOfClass, Map<Id,Class__c>mapOfClassDeatils)
    {
        System.debug('listOfClass------------.'+listOfClass);
        System.debug('mapOfClassDeatils------------.'+mapOfClassDeatils);
        
        if(listOfClass != null || mapOfClassDeatils != null)
        {
            List<Id>listOfParentId=new List<Id>();
            
            System.debug('-----------------Setup 1 clear');
            
            for(Class__c cl : listOFClass != null ? listOfClass : mapOfClassDeatils.values())
            {
                listOfParentId.add(cl.school__c);
            }
            if(listOfParentId.size() > 0 && listOfParentId != null)
            {
               System.debug('-----------------Setup 2 clear And Call');
               AssesmentPractice.NoOfClassesEasyWayTo(listOfParentId[0]);
            }
        }
    }
    

}