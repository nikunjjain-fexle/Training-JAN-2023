/*
 * Purpose      :  All 
 * 
 * Created By   : Nikunj Jain
 * 
 * Created Date : 14-04-2023
 * 
 * Revision Log : 
 */
public class PracticeToday {
    
    public static void doApexSharing(List<School__c>listOfSchool, Map<Id,School__c>mapOfSchoolDetails)
    {
        Set<id>setOfEligibleApexSharingAddition=new Set<Id>();
        Set<id>setOfEligibleApexSharingDeletion=new Set<Id>();
        Boolean isAnyRelatventChangeHappens=false;
        
        for(School__c sch :listOfSchool)
        {
            
            if(mapOfSchoolDetails != null)
            {
                if(sch.No_Of_Teachers__c != mapOfSchoolDetails.get(sch.id).No_Of_Teachers__c)
                {
                    if(sch.No_Of_Teachers__c != null)
                    {
                        
                        if(sch.No_Of_Teachers__c  > Integer.valueOf(System.Label.NO_OF_TEACHERS_THRESHOLD_FOR_SHARING_RECALCULATION))
                        {
                            setOfEligibleApexSharingAddition.add(sch.id);
                        }
                        else
                        {
                            setOfEligibleApexSharingDeletion.add(sch.id);
                        }
                    }
                    else
                    {
                        setOfEligibleApexSharingDeletion.add(sch.id);
                    }
                    isAnyRelatventChangeHappens=true;
                    
                }
            }
            List<User>integrationUserDetails=new List<User>();
            
            
            if(isAnyRelatventChangeHappens)
            {
                if(setOfEligibleApexSharingAddition.size() > 0 || setOfEligibleApexSharingDeletion.size() >0)
                {
                    
                    integrationUserDetails=[SELECT Id FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
                }
                if(integrationUserDetails.size()>0){
                    
                    List<School__share>listApexShare=new List<School__share>();
                    
                    if(setOfEligibleApexSharingAddition.size() > 0)
                    {
                        
                        for(Id schl:setOfEligibleApexSharingAddition)
                        {
                            School__share schlShare= new School__share();
                            schlShare.parentId=Schl;
                            schlShare.UserOrGroupId=integrationUserDetails[0].id;
                            schlShare.AccessLevel='Read';
                            schlShare.RowCause=Schema.School__share.RowCause.Apex_Sharing__c;
                            
                            listApexShare.add(schlShare);
                        }
                        if(listApexShare.Size()>0)
                        {
                            Utilities.ByPassAllTriggers=true;
                            insert listApexShare;
                            Utilities.ByPassAllTriggers=false;
                        }
                    }
                    
                }
            }
            if(setOfEligibleApexSharingDeletion.size() > 0 && setOfEligibleApexSharingDeletion != null)
            {
                
            }
            
            
        }
    }
    
    public static void doCalculations(Map<Id,School__c>mapOfSchool)
    {
        if(mapOfSchool.Size()>0 && mapOfSchool!=null)
        {
            Map<Id,Integer>mapOfSchoolDetails=new Map<Id,Integer>();
            
            for(Id sch :mapOfSchool.KeySet())
            {
                mapOfSchoolDetails.put(sch, 0);
            }
            
            for(Student__c std : [SELECT Id, Name, School__c FROM STudent__c WHERE School__c != null  AND School__c =:mapOfSchool.KeySet()])
            {
                if(!mapOfSchoolDetails.ContainsKey(Std.School__c))
                {
                    mapOfSchoolDetails.put(Std.School__c,1);
                }
                else
                {
                    mapOfSchoolDetails.put(Std.School__c, (mapOfSchoolDetails.get(Std.School__c))+1);
                }
            }
            if(mapOfSchoolDetails.size() >0 )
            {
                List<School__c>listOfSchools=new  List<School__c>();
                
                for(School__c sch:mapOfSchool.Values())
                {
                    if(mapOfSchoolDetails.containsKey(sch.id))
                    {
                        sch.No_OF_STUDENT__c=mapOfSchoolDetails.get(sch.id);
                    }
                    else
                    {
                        sch.No_OF_STUDENT__c=0;
                    }
                    listOfSchools.add(sch);
                }
                if(!listOfSchools.isEmpty())
                {
                    Utilities.ByPassAllTriggers=true;
                    update listOfSchools;
                    Utilities.ByPassAllTriggers=false;
                }
            }
        }
        else
        {
            System.debug('please No Data');
        }
    }
    
     public static void noOfClassesHardWay(Id SchoolId)
     {
         if(SchoolId !=null)
         {
             Map<Id,School__c>mapOfSchool=new  Map<Id,School__c>();
             for(School__c sch :[SELECT Id, No_Of_Class__c FROM School__c WHERE ID =:SchoolId])
             {
                 mapOfSchool.put(sch.id,sch);
             }
             if(mapOfSchool.size() > 0)
             {
                 Map<Id,Integer>mapOfClasseCount=new Map<Id,Integer>();
                 for(Class__c cl : [SELECT Id, school__c FROM Class__c 
                                    WHERE Id != null 
                                    AND school__c != null 
                                    AND school__c =:mapOfSchool.KeySet()])
                 {
                     if(!mapOfClasseCount.ContainsKey(cl.School__c))
                     {
                         mapOfClasseCount.put(cl.School__c, 1);
                     }
                     else
                     {
                          mapOfClasseCount.put(cl.School__c,( mapOfClasseCount.get(cl.School__c))+1);
                     }
                 }
                 if(mapOfClasseCount.size() >0)
                 {
                     List<School__c>listOfSchool=new  List<School__c>();
                     for(School__c sch:mapOfSchool.Values())
                     {
                         if(mapOfClasseCount.ContainsKey(sch.id))
                         {
                             sch.No_Of_Class__c=mapOfClasseCount.get(Sch.id);
                         }
                         else
                         {
                               sch.No_Of_Class__c=0;
                         }
                          listOfSchool.add(sch);
                     }
                    
                     if(listOfSchool.size() >0)
                     {
                         update listOfSchool;
                     }
                     System.debug('listOfSchool------------------'+listOfSchool);
                 }
                 else
                 {
                     System.debug('No Class');
                 }
             }
             else
             {
                 System.debug('No School');
             }
         }
         else
         {
             System.debug('Sorry Please Input Valid Id');
         }
     }
    
    public static void noOfClasses(Id SchoolId)
    {
        if(SchoolId != null)
        {
           List<School__c>listOfSchoolsDetail=[SELECT Id, NO_OF_Class__c , (SELECT Id FROM Classes__r)FROM School__c WHERE ID =:SchoolId];
            if(listOfSchoolsDetail.size()>0)
            {
                for(School__c sch:listOfSchoolsDetail)
                {
                    sch.No_Of_Class__c=sch.Classes__r.size();
                }
                if(!listOfSchoolsDetail.isEmpty())
                {
                    update listOfSchoolsDetail;
                }
              System.debug('listOfSchoolsDetail-------'+listOfSchoolsDetail);
            }
            else
            {
                System.debug('No Class');
            }
        }
        else
        {
            System.debug('Please Enter Valid Id');
        }
        
    }
    
    public static void noOfStudents(String SchoolName)
    {
        if(String.isNotBlank(SchoolName))
        {
            Map<Id,School__c>mapOfSchoolsDetails=new Map<Id,School__c>();
            
            for(School__c schl: [SELECT Id , No_Of_Student__c FROM School__c WHERE Name =: SchoolName.trim()])
            {
                mapOfSchoolsDetails.put(schl.id, schl);
            }
            
            System.debug('mapOfSchoolsDetails-----'+mapOfSchoolsDetails);
            
            if(mapOfSchoolsDetails.Values().size() > 0 && mapOfSchoolsDetails != null)
            {
                Map<Id,Integer>mapOfStudents=new Map<Id,Integer>();
                
                for(Student__c students: [SELECT ID, Class__c, Class__r.School__c FROM Student__c 
                                          WHERE Class__c != null 
                                          AND Class__r.School__c != null 
                                         AND Class__r.School__c =:mapOfSchoolsDetails.keySet()])
                {
                    if(!mapOfStudents.ContainsKey(Students.class__r.school__c))
                    {
                        mapOfStudents.put(Students.class__r.school__c, 1);
                    }
                    else
                    {
                        mapOfStudents.put(Students.class__r.school__c,(mapOfStudents.get(Students.class__r.school__c))+1);
                    }
                }
                
                System.debug('mapOfStudents-----'+mapOfStudents);
                
                if(mapOfStudents.size()>0 && mapOfStudents != null)
                {
                    List<School__c>listOfSchoolDetails=new List<School__c>();
                    
                    for(School__c sch :mapOfSchoolsDetails.Values())
                    {
                        if(mapOfStudents.ContainsKey(sch.id))
                        {
                            sch.No_Of_Student__c=mapOfStudents.get(sch.id);
                        }
                        else
                        {
                            sch.No_Of_Student__c=0;
                        }
                        listOfSchoolDetails.add(sch);
                    }
                    System.debug('No of Student on School-----'+listOfSchoolDetails);
                    if(!listOfSchoolDetails.isEmpty())
                    {
                        update listOfSchoolDetails;
                    }
                   
                }
                else
                {
                    School__c scRecord=new School__c();
                    scRecord.No_Of_Student__c=0;
                    scRecord.id=new List<Id>(mapOfSchoolsDetails.KeySet())[0];
                    update scRecord;
                    
                }
            }
            else
            {
                System.debug('Sorry No Related School Now');
            }
        }
        else
        {
            System.debug('Please Enter Valid Input : THANK YOU !');
        }
        
    }
    
    public static void dyanmicWayToDealWithCollections()
    {
        //  School Name ---> Class Name ----> Studennt Name--->
        Map<String,Map<String,List<Student__c>>> mapOfSchoolDetails=new  Map<String,Map<String,List<Student__c>>>();
        
        for(Student__c students :[SELECT Id, Name, Class__r.School__r.Name, Class__r.Name FROM Student__c
                                  WHERE Class__r.Name != null
                                  AND Class__r.school__r.Name != null
                                  ])
        {
            if(mapOfSchoolDetails.containsKey(Students.Class__r.school__r.Name))
            {
                if(mapOfSchoolDetails.get(Students.Class__r.school__r.Name).containsKey(Students.Class__r.Name))
                {
                    mapOfSchoolDetails.get(Students.Class__r.school__r.Name).get(Students.Class__r.Name).add(Students);
                }
                else
                {
                    mapOfSchoolDetails.get(Students.Class__r.school__r.Name).put( Students.Class__r.Name,new List<Student__c>());
                }
            }
            else
            {
                Map<String,List<Student__c>>mapOfClassesDetails=new Map<String,List<Student__c>>();
                
                if(mapOfClassesDetails.get(Students.class__r.Name)== null)
                {
                    mapOfClassesDetails.put(Students.Class__r.Name,new List<Student__c>());
                }
                
                mapOfClassesDetails.get(Students.Class__r.Name).add(students);
                
                mapOfSchoolDetails.put(Students.Class__r.school__r.Name, mapOfClassesDetails);
                
            }
        }
        System.debug('mapOfSchoolDetails------------->'+mapOfSchoolDetails.Keyset());
    }
    
    
    
    

    public static void StaticWayToDealWithCoolections()
    {
        Map<String,Map<String,List<String>>>mapOfAllCountry=new Map<String,Map<String,List<String>>>
        {
            'INDIA'=> new Map<String,List<String>>
            {
                'Rajasthan'=> new List<String>{'Udaipur','Jaipur','Dungarpur'},
                    'Punjab'=> new List<String>{'Ludhana', 'Chandigarh','Mini Punjab'}
            },
                'USA'=> new Map<String,List<String>>
            {
                'New YORK'=> new List<String>{'NY1','NY2','NY3'},
                    'Woshington'=> new List<String>{'WY1','WY2','WY3'}
            }
        };
            
        System.debug('mapOfAllCountry ---->'+mapOfAllCountry);
        
        
    }
}