/*
 * Purpose      : Find Number Of Student And Number Of Classes By different Way
 * 
 * Created By   : Nikunj jain
 * 
 * Created Date : 27/03/2023
 * 
 * Version      : V_0.1
*/

public Without Sharing class CountManagerOld {
    
    public static void doCalculationsForNoOfStudents(Map<Id,School__c>mapOfSchools)
      {
        
        if(mapOfSchools.Values() != null  && mapOfSchools.values().size() > 0)
        {
            Map<Id,Integer>mapOfSchoolIdWithNoOfStudentCount=new Map<Id,Integer>();
            
            for(Id schoolId : mapOfSchools.KeySet())
            {
                mapOfSchoolIdWithNoOfStudentCount.put(schoolId,0);
            }
            
            for(Student__c std: [SELECT ID, School__c 
                                 FROM Student__c 
                                 WHERE School__c != null 
                                 AND School__c IN : mapOfSchools.KeySet()])
                
            {
                if(!mapOfSchoolIdWithNoOfStudentCount.containsKey(std.School__c))
                {
                    mapOfSchoolIdWithNoOfStudentCount.put(std.School__c,1);
                    
                }
                else
                {
                     mapOfSchoolIdWithNoOfStudentCount.put(std.School__c,(mapOfSchoolIdWithNoOfStudentCount.get(std.School__c)+1));
                }
            }
            
            if(mapOfSchoolIdWithNoOfStudentCount.values() != null && mapOfSchoolIdWithNoOfStudentCount.Values().size() > 0)
            {
                
                List<School__c> listOfSchoolsToBeUpdated = new List<School__c>();
                
                for(School__c sch: mapOfSchools.values())
                {
                    School__c sc=mapOfSchools.get(sch.id);
                    
                    if(mapOfSchoolIdWithNoOfStudentCount.containsKey(sch.id))
                    {
                        sc.No_Of_Student__c=mapOfSchoolIdWithNoOfStudentCount.get(sch.Id);
                    }
                    else
                    {
                        sc.No_Of_Student__c=0;
                    }
                    
                    listOfSchoolsToBeUpdated.add(sc);
                }
                
                if(listOfSchoolsToBeUpdated.size() > 0)
                {
                    Utilities.BypassAllTriggers=true;
                    update listOfSchoolsToBeUpdated;
                    Utilities.BypassAllTriggers=false;
               }
                
            }     
        }
        
      }
    
    
    public static void updateNoOfStudentsDetails(String SchoolName)
    {
        
        if(String.isNotBlank(SchoolName))
        {
            Map<Id,School__c> mapOfSchool = new  Map<Id,School__c>();
            
            for(School__c school : [SELECT ID, No_Of_Student__c 
                                    FROM School__c 
                                    WHERE Name =: SchoolName.trim()
                                   ])
            {
                mapOfSchool.put(school.Id,school);
            }
            
            if(mapOfSchool.values() != null && mapOfSchool.size() > 0)
            {
                Map<Id,Integer>mapOfNoOfStudent=new Map<Id,Integer>();
                
                for(Student__c student: [SELECT Id, Class__r.School__c
                                         FROM Student__c
                                         WHERE Class__c !=null
                                         AND Class__r.School__c !=null
                                         AND Class__r.School__c  IN :mapOfSchool.KeySet()
                                        ])
                {
                    if(!mapOfNoOfStudent.containsKey(student.Class__r.School__c))
                    {
                        mapOfNoOfStudent.put(student.Class__r.School__c,1);
                    }
                    else{
                        mapOfNoOfStudent.put(student.Class__r.School__c,(mapOfNoOfStudent.get(student.Class__r.School__c)+1));
                    }
                }
                
                
                
                if(mapOfNoOfStudent.values() != null && mapOfNoOfStudent.values().size()>0)
                {
                    List<School__c> listOfSchoolToBeUpdated=new  List<School__c> ();
                    
                    for(School__c sch : mapOfSchool.values())
                    {
                        
                        if(mapOfNoOfStudent.containsKey(sch.id))
                        {
                            sch.No_Of_Student__c=mapOfNoOfStudent.get(sch.Id);
                        }
                        else
                        {
                            sch.No_Of_Student__c=0;    
                        }
                        listOfSchoolToBeUpdated.add(sch);
                    }
                    if(listOfSchoolToBeUpdated.size()>0)
                    {
                        update listOfSchoolToBeUpdated;
                    }
                    System.debug('--------------------------------------->'+listOfSchoolToBeUpdated);
                    
                }
                else
                {
                    School__c scRecord=new School__c();
                    scRecord.No_Of_Student__c=0;
                    scRecord.Id=(new List<Id>(mapOfSchool.KeySet()))[0];
                    update scRecord;
                }
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
    
    
    
    public static void updateNoOfClassesDetails(Id SchoolId)
    {
        if(SchoolId != null)
        {
             List<School__c> listOfSchool = [SELECT Id, Name,
                                             (SELECT ID FROM Classes__r) 
                                             FROM School__c 
                                             WHERE Id =:SchoolId
                                            ];
            
            if(listOfSchool.Size () > 0)
            {
                for( School__c sc : listOfSchool)
                {
                    sc.No_Of_Class__c = sc.classes__r.size();
                }
                System.debug('List Before Update Of No Of Student ----'+listOfSchool);
                
                update listOfSchool;
                
                System.debug('List Of No Of Student ----'+listOfSchool);
            }
            else
            {
                System.debug(System.LABEL.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);
            }
            
        }
        else{
            System.debug(System.LABEL.ERROR_MSG_SCHOOL_DETAILS_MISSING);
        }
        
        
    }
    
    // Third
    public static void updateNoOfClassesDetails2(Id SchoolId)
    {
        if(SchoolId != null)
        {
             List<School__c>listOfSchool=[SELECT Id, Name 
                                          FROM School__c 
                                          WHERE Id =:SchoolId
                                         ];
            
             if(listOfSchool.Size () > 0)
            {
                Map<Id,Integer> mapOfSchoolWithClassCount = new Map<Id,Integer>();
                
                for(AggregateResult aggRes : [SELECT Count(Id) No_Of_Class__c, School__c SchoolId
                                              FROM Class__c
                                              WHERE School__c =: schoolId
                                              GROUP BY School__c
                                             ])
                {
                    Id SchoolRecordId = (Id)AggRes.get('SchoolId');
                    integer numberOfAssociatedClasses = (Integer) aggRes.get('No_Of_Class__c');
                    mapOfSchoolWithClassCount.put(SchoolRecordId,numberOfAssociatedClasses);
                    
                }
                
                if(mapOfSchoolWithClassCount.values() != null && mapOfSchoolWithClassCount.values().size() > 0)
                {
                    List<School__c> listOfSchoolToBeUpdated = new List<School__c>();
                    
                    for(Id scId: mapOfSchoolWithClassCount.KeySet())
                    {
                        School__c scRec = new School__c();
                        scRec.Id = scId;
                        scRec.No_of_Class__c = mapOfSchoolWithClassCount.get(scId);
                        listOfSchoolToBeUpdated.add(scRec);
                    }
                    
                    System.debug('listOfSchoolToBeUpdated----'+listOfSchoolToBeUpdated);
                    
                    if(listOfSchoolToBeUpdated.size () > 0)
                    {
                        update listOfSchoolToBeUpdated;
                    }
                }
                else
                {
                    System.debug(System.LABEL.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);
                }
            
            }
        }
        else
        {
            System.debug(System.LABEL.ERROR_MSG_SCHOOL_DETAILS_MISSING);
        }
        
    }

}