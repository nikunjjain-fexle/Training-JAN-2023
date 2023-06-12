/*
 * Purpose       : Find No Of Student And no Of Classes On School Object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 27-03-2023
 * 
 * Revison Log   : V_1.0 27-03-2023
 *                 V_1.1 Modified By Nikunj jain 11-04-2023
*/

public Without sharing class SchoolTriggerHandler {
    
    

    public static void doApexSharingCalculations(List<School__c>schools, Map<Id,School__c>mapOfOldShcools)
    {
        Set <Id> setOfEligibleSchoolForSharingAddition = new Set <Id>();
        Set <Id> setOfEligibleSchoolForSharingDeletion = new Set <Id>();
        
        Set<String>setOfSchoolsName=new Set<String>();
        
        Boolean isAnyRelatventChangeHappens=false;
        
        for(School__c sch :schools)
        {
            if(mapOfOldShcools != null)
            {
                if(System.isBatch() || (sch.No_Of_Teachers__c != mapOfOldShcools.get(sch.id).No_Of_Teachers__c))
                {
                    if(sch.No_Of_Teachers__c != null)
                    {
                        if(sch.No_Of_Teachers__c > Integer.ValueOf(System.Label.NO_OF_TEACHERS_THRESHOLD_FOR_SHARING_RECALCULATION))
                        {
                            setOfEligibleSchoolForSharingAddition.add(sch.id);

                        }
                        else
                        {
                            setOfEligibleSchoolForSharingDeletion.add(sch.id);
                        }
                    }
                    else
                    {
                        setOfEligibleSchoolForSharingDeletion.add(sch.id);
                    }
                    isAnyRelatventChangeHappens=true;
                }
            }
        }

        List<User>integrationUserDetails=new List<User>();
        
        if(isAnyRelatventChangeHappens)
        {
            if(setOfEligibleSchoolForSharingAddition.size() > 0  || setOfEligibleSchoolForSharingDeletion.size() > 0)
            {
                integrationUserDetails=[SELECT Id FROM User WHERE Id =:System.Label.INTEGERATION_USER_RECORD_ID AND IsActive =True];
            }
            
            if(integrationUserDetails.size() > 0)
            {
                List<School__share> listOfManageSharingRecordToBeInserted=new List<School__share>();
                
                if(setOfEligibleSchoolForSharingAddition.size()>0)
                {
                    // Loop Over School Records and Create Sharing Record for the Integration User
                   for(ID Schl : setOfEligibleSchoolForSharingAddition)
                   {
                    School__share schlShare= new School__share();
                    schlShare.parentId=Schl;
                    schlShare.UserOrGroupId=integrationUserDetails[0].id;
                    schlShare.AccessLevel='Read';
                    schlShare.RowCause=Schema.School__share.RowCause.Apex_Sharing__c;
                    listOfManageSharingRecordToBeInserted.add(schlShare);
                   }
    
                   if(listOfManageSharingRecordToBeInserted.size() >0)
                   {
                    Utilities.BypassAllTriggers=true;
                    insert listOfManageSharingRecordToBeInserted;
                    Utilities.BypassAllTriggers=false;
                       
                    // via Future Method   
                   //HerokuAppResponseManager.makeCallOutHerokuUpdateUser(setOfEligibleSchoolForSharingAddition);
                   
                   Queueable_UpdateUserWithHerokuAppDetails queueableJob=new Queueable_UpdateUserWithHerokuAppDetails(setOfEligibleSchoolForSharingAddition);
                   Id jobId= System.enqueueJob(queueableJob);
                       
                   }
    
                }
                
                List<School__share> listOfManagedSharingRecordsToBeDeleted=new List<School__share>();
                
                if(setOfEligibleSchoolForSharingDeletion.size()>0)
                {
                   listOfManagedSharingRecordsToBeDeleted = [SELECT Id, ParentId, RowCause, UserOrGroupId 
                                                                                  FROM School__share 
                                                                                  WHERE ParentId IN: setOfEligibleSchoolForSharingAddition 
                                                                                  AND RowCause =: Constants.SHARING_REASON_APEX_SHARING];
                    if(listOfManagedSharingRecordsToBeDeleted.size() >0)
                    {
                        Utilities.BypassAllTriggers=true;
                        delete listOfManagedSharingRecordsToBeDeleted;
                        Utilities.BypassAllTriggers=false;
                    }
            }
        }
        else
        {
            Schools[0].addError(System.Label.ERROR_INTEGRATION_USER_IS_DEACTIVED);
        }          
        
        }
        
        
    }
    
    
    
    
    
    
    
//---------------------------------------------------------------------------------------------------------------------------------------------------------    
    
     public static void updateNoOfStudentsDetails(List<School__c>newSchool,Map<Id,School__c>oldMapOfSchools)
     {
         Set<Id>setOfEligibleSchools=new Set<Id>();
         
         for(School__c sch: newSchool)
         {
             // only execute in the case of update 
             // only execute in the case update No of Student
             
             if(oldMapOfSchools != null && sch.No_Of_student__c != oldMapOfSchools.get(sch.Id).No_Of_student__c){
                 setOfEligibleSchools.add(sch.id);
             }
             
         }
         
         if(setOfEligibleSchools.size() > 0)
         {
             
             
             // an Additional Query Because Trigger.new is a read only Collection in case of after Event
             Map<Id,School__c> mapOfSchools = new Map<Id,School__c>();
             
             for(School__c sch: [SELECT ID, No_Of_Student__c
                              FROM School__c
                              WHERE ID IN :setOfEligibleSchools])
             {                 
                 mapOfSchools.put(sch.Id,sch); 
             }
             
             if(mapOfSchools.Values().size() > 0)
             {
                PracticeToday.doCalculations(mapOfSchools);
             }
         }
     }
    
    
        
     
    
//------------------------------------------------------------------------------------------------------------------
    
     public static void updateNoOfClassesDetailsInBeforeCase(List<School__c>newList,Map<Id,School__c>MapList){
        
        Set<Id>setOfSchoolIds=new Set<Id>();
        
        for(School__c sch: newList)
        {
            setOfSchoolIds.add(sch.Id);
        }
        
        if(setOfSchoolIds.size() > 0)
        {
            Map<Id,Integer>mapOfNoOfClassesAndCounts=new Map<Id,Integer>();
            
            for(Class__c cl : [SELECT Id,School__c FROM class__c 
                               WHERE School__c IN :setOfSchoolIds])
            {
                if(!mapOfNoOfClassesAndCounts.ContainsKey(cl.School__c))
                {
                    mapOfNoOfClassesAndCounts.put(cl.School__c,1);
                }
                else
                {
                    mapOfNoOfClassesAndCounts.put(cl.School__c,(mapOfNoOfClassesAndCounts.get(cl.School__c)+1));
                }
            }
            
            if(mapOfNoOfClassesAndCounts.values().size() > 0)
            {
                
                for(School__c s: newList)
                {
                    if(mapOfNoOfClassesAndCounts != null ){
                        s.No_of_Class__c=mapOfNoOfClassesAndCounts.get(s.Id);
                    }
                }
            }
            else
            {
                newList[0].No_of_Class__c = 0;
            }
        }
        
    }
 
    
     public static void updateNoOfStudentsDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
     {
        //Map to hold the school record Id as a key and then upto recalculated number of students counts as value
        map<Id, Integer> mapOfSchoolsIdWithNoOfStudentsCounts = new Map<Id, Integer>();
        
        for(School__c sch : schools)
        {
            mapOfSchoolsIdWithNoOfStudentsCounts.put(sch.Id, 0);
        }
        if(mapOfSchoolsIdWithNoOfStudentsCounts.values().size()>0)
        {
            for(Student__c student : [SELECT Id, School__c
                                     FROM Student__c
                                     WHERE School__c != null
                                     AND School__c IN : mapOfSchoolsIdWithNoOfStudentsCounts.keySet()])
            {
                if(!mapOfSchoolsIdWithNoOfStudentsCounts.containsKey(student.School__c))
                {
                    mapOfSchoolsIdWithNoOfStudentsCounts.put(student.School__c, 1);
                }
                else
                {
                    mapOfSchoolsIdWithNoOfStudentsCounts.put(student.School__c, (mapOfSchoolsIdWithNoOfStudentsCounts.get(student.School__c)+1));
                }
            }
            for(School__c sc : schools)
            {
                if(mapOfSchoolsIdWithNoOfStudentsCounts.get(sc.Id) != null)
                {
                    sc.No_Of_Student__c = mapOfSchoolsIdWithNoOfStudentsCounts.get(sc.id);
                }
            }
        }
    }

}