/**
 * Purpose       : Trigger handler Class of Class Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 03-04-2023
 * 
 * Version       : V_01
 * 
**/

public without sharing class ClassTriggerHandler {
    
    
    
    public static void updateNumberOfClassesDetails(List<Class__c> classes, Map<Id, Class__c> mapOfOldClasses)
    {
        Set<Id> setOfParentSchools = new Set<Id>();
        
        for(Class__c cls : classes != null ? classes : mapOfOldClasses.values())
        {
            if(cls.School__c != null)
            {
                setOfParentSchools.add(cls.School__c);
            }
        }
        
        if(setOfParentSchools.size() > 0)
        {
            updateNoOfClassesDetails(setOfParentSchools);
        }
        
    }
    public static void updateNoOfClassesDetails(Set<Id> schoolId)
    {
        if(schoolId.size() >0)
        {
            List<School__c> schools = [SELECT Id, Name,
                                       (SELECT ID FROM Classes__r)
                                       FROM School__c
                                       WHERE Id =: schoolId
                                      ]; 
            if(schools.size() > 0)
            {
                for (School__c sc : schools)
                {
                    sc.No_of_Class__c = sc.Classes__r.size();
                }
                //System.debug('@@@@ schools ' + schools);
                
                Utilities.BypassAllTriggers = true;
                update schools;
                Utilities.BypassAllTriggers = false;
            }
            else
            {
                //System.debug(System.Label.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_ID);
                System.debug(System.LABEL.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);
            }
        }
        else
        {
            //System.debug(System.Label.ERROR_MSG_SCHOOL_NAME_DETAILS_MISSING);
            System.debug(System.LABEL.ERROR_MSG_SCHOOL_DETAILS_MISSING);
        }
    }

    
    public static void ClassDeletion(List<Class__c>listOfOldClass,Map<Id,Class__c>oldMapOfClass)
    {
        for(Class__c cl:[SELECT ID FROM Class__c 
                         WHERE ID IN (SELECT Class__c FROM Student__c) 
                         AND ID IN : Trigger.old])
        {
            Trigger.oldMap.get(cl.Id).addError('You can Not Deleted class because Student is in the class');
        }
    }
    
    
    /*
   public static void showErrorWhenTryToDeleteChildRecord(List<Class__c>oldOfClass)
   {
      List<Student__c>relatedStudent=[SELECT Id FROM Student__c WHERE Class__c IN :oldOfClass];
       
      for(Class__c cl:oldOfClass)
      {
          if(relatedStudent.size()>0)
          {
              cl.addError('You can not Delete This Class Becuase have Realated Student with');
          }
      }
     
   }*/
}