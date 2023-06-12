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
public class AssessmentSchoolHandler {
    
    public static void upadteNoOfStudentInBeforeCase(List<School__c>listOfSchool, Map<Id,School__c>mapOfSchool)
    {
        if(mapOfSchool != null || listOfSchool != null)
        {
            Set<id>setOfSchoolId=new Set<id>();
            for(School__c sch:listOfSchool)
            {
                if(sch.No_Of_Student__c != null && sch.No_Of_Student__c != mapOfSchool.get(sch.id).No_Of_Student__c)
                {
                    setOfSchoolId.add(Sch.id);
                }
            }
            
            if(setOfSchoolId != null && setOfSchoolId.size() > 0)
            {
               Map<Id,Integer>mapOfStudentCount=new Map<Id,Integer>();
               for(Student__c std : [SELECT Id, Class__c, School__c FROM Student__c WHERE
                                     Class__c != null 
                                     AND School__c =:setOfSchoolId ])
               {
                   if(!mapOfStudentCount.ContainsKey(std.School__c))
                   {
                       mapOfStudentCount.put(std.School__c,1);
                   }
                   else
                   {
                       mapOfStudentCount.put(std.School__c,mapOfStudentCount.get(std.School__c)+1);
                   }
                  
               }
                if(mapOfStudentCount != null)
                {
                    for(School__c sch: listOfSchool)
                    {
                         if(mapOfStudentCount.ContainsKey(sch.id))
                        {
                            sch.No_of_Student__c=mapOfStudentCount.get(sch.id);
                        }
                        else
                        {
                            
                            sch.No_of_Student__c=0;
                        }
                    }
                }
                
            }
        }
    }
    public static void upadteNoOfClassInBeforeCase(List<School__c>listOfSchool, Map<Id,School__c>mapOfSchool)
    {
        if(mapOfSchool != null || listOfSchool != null)
        {
            Map<Id,Integer>mapOfSchoolDetails=new Map<Id,Integer>();
            for(School__c sch :listOfSchool)
            {
                mapOfSchoolDetails.put(Sch.id, 0);
            }
            if(mapOfSchoolDetails != null)
            {
                for(Class__c cl: [SELECT ID, School__c FROM Class__c WHERE School__c =:mapOfSchoolDetails.KeySet()])
                {
                    if(!mapOfSchoolDetails.ContainsKey(cl.School__c))
                   {
                       mapOfSchoolDetails.put(cl.School__c,1);
                   }
                   else
                   {
                       mapOfSchoolDetails.put(cl.School__c,mapOfSchoolDetails.get(cl.School__c)+1);
                   }
                }
                if(mapOfSchoolDetails != null)
                {
                    for(School__c std : listOfSchool)
                    {
                        if(mapOfSchoolDetails.ContainsKey(std.id))
                        {
                            std.No_Of_Class__c=mapOfSchoolDetails.get(std.id);
                        }
                        else
                        {
                            std.No_Of_Class__c=0;
                        }
                    }
                }
            }
        }
    }

}