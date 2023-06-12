/*
 * Purpose       :  Practice of All Assignment
 * 
 * Created By    :  Nikunj jain
 * 
 * Created Date  : 
 * 
 * Version       :  V_01
 */



public without Sharing  class PracticeClass {
    
    public static void updateNoOfClassDetails(Id SchoolId)
    {
        if(SchoolId !=null)
        {
            List<School__c>listOfSchool=[SELECT ID, Name FROM School__c WHERE Id =:SchoolId];
            
            if(listOfSchool.size()>0)
            {
                Map<Id,integer>mapOfNoOfStudentsWithClassCount=new Map<Id,integer>();
                
                for(AggregateResult aggRe:[SELECT Count(ID)  No_Of_Class__c ,School__c SchoolId FROM Class__c WHERE School__c =:SchoolId GROUP BY School__c])
                {
                    Id SchoolRecordId=(Id)aggRe.get('SchoolId');
                    
                    Integer NoOfAssocaiteClass=(Integer)aggRe.get('No_Of_Class__c');
                    
                    mapOfNoOfStudentsWithClassCount.put(SchoolRecordId,NoOfAssocaiteClass);
                    
                }
                
                System.debug('--->'+mapOfNoOfStudentsWithClassCount);
                
                if(mapOfNoOfStudentsWithClassCount.values() !=null && mapOfNoOfStudentsWithClassCount.values().size()>0)
                {
                    List<School__c>listOfSchoolToBeUpdated=new List<School__c>();
                    
                    for(Id ids:mapOfNoOfStudentsWithClassCount.keySet())
                    {
                        School__c scRec=new School__c();
                        scRec.id=ids;
                        scRec.No_Of_Class__c=mapOfNoOfStudentsWithClassCount.get(ids);
                        listOfSchoolToBeUpdated.add(scRec);
                    }
                    if(listOfSchoolToBeUpdated.size()>0)
                    {
                        update listOfSchoolToBeUpdated;
                    }
                    System.debug('--->'+listOfSchoolToBeUpdated);
                }
                else
                {
                    System.debug(System.LABEL.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);
                }
                
            }       
            else
            {
                System.debug('Sorry No Class on School');
            }
        }
        else
        {
            System.debug(System.LABEL.ERROR_MSG_SCHOOL_DETAILS_MISSING);
        }
    }
    
    public Static void updateNoOfClasses(Id SchoolName)
    {
        if(SchoolName!=null){
            
            List<School__c>listOfSchoolDetails=[SELECT ID,Name,(SELECT ID, Name FROM Classes__r)FROM School__c WHERE ID =:SchoolName];
            if(listOfSchoolDetails.size()>0)
            {
                for(School__c s:listOfSchoolDetails)
                {
                    s.No_Of_Class__c=s.Classes__r.size();
                }
                update listOfSchoolDetails;
                System.debug('----------------------->'+listOfSchoolDetails);
            }
            else{
                System.debug('No Class');
            }
        }
        else{
            System.debug('Please Enter Valid Input');
        }
    }
    
    public Static void updateNoOfStudent(String SchoolName)
    {
        if(String.isNotBlank(SchoolName))
        {
            Map<id,School__c>mapOfSchools=new Map<id,School__c>();
            for(School__c schools:[SELECT ID, Name, No_Of_Student__c FROM School__c WHERE NAME =:SchoolName.trim()])
            {
                mapOfSchools.put(Schools.id,Schools);
            }
            System.debug('----mapOfSchools------>'+mapOfSchools);
            
            if(mapOfSchools.values()!=null && mapOfSchools.size()>0)
            {
                Map<Id,Integer>mapOfNoOfStudentDetails=new Map<Id,Integer>();
                for(Student__c student:[SELECT ID,Name, Class__r.Name, Class__r.School__r.Name FROM Student__c
                                        WHERE Class__c !=null
                                        AND Class__r.SchooL__c !=null
                                        AND Class__r.SchooL__c IN : mapOfSchools.KeySet()])
                {
                    if(!mapOfNoOfStudentDetails.containsKey(Student.Class__r.school__c))
                    {
                        mapOfNoOfStudentDetails.put(Student.Class__r.school__c,1);
                    }
                    else
                    {
                        mapOfNoOfStudentDetails.put(Student.Class__r.school__c,(mapOfNoOfStudentDetails.get(Student.Class__r.school__c)+1));
                    }
                }
                
                System.debug('----mapOfNoOfStudentDetails------>'+mapOfNoOfStudentDetails);
                
                if(mapOfNoOfStudentDetails.values()!=null  && mapOfNoOfStudentDetails.values().size()>0)
                {
                    List<School__c> listOfSchoolToBeUpdated=new  List<School__c> ();
                    for(School__c s:mapOfSchools.values())
                    {
                        if(mapOfNoOfStudentDetails.ContainsKey(s.id))
                        {
                            s.No_Of_Student__c=mapOfNoOfStudentDetails.get(s.id);
                        }
                        else
                        {
                            s.No_Of_Student__c=0;
                        }
                        listOfSchoolToBeUpdated.add(s);
                    }
                    if(listOfSchoolToBeUpdated.size()>0)
                    {
                        update listOfSchoolToBeUpdated;
                    }
                    System.debug('---------->'+listOfSchoolToBeUpdated);
                    
                }
                else
                {
                    School__c scRecord=new School__c();
                    scRecord.No_Of_Student__c=0;
                    scRecord.Id=(new List<Id>(mapOfSchools.KeySet()))[0];
                    update scRecord;
                }
            }
            else
            {
                System.debug('No School here');
            }
        }
        else
        {
            System.debug('Please Enter Valid Values Thanks');
        }
        
    }
    
    
    
    
    
    
    
    
    public static void dynamicWayToDealWithCollections()
    {
        Map<String,Map<String,List<String>>>mapOfSchoolDetails=new Map<String,Map<String,List<String>>>();
        
        for(Student__c student:[SELECT Id, Name, Class__r.Name, Class__r.school__r.Name FROM Student__c where Class__r.Name !=null AND Class__r.school__r.Name !=null])
        {
            if(mapOfSchoolDetails.ContainsKey(student.Class__r.School__r.Name))
            {
                if(mapOfSchoolDetails.get(Student.Class__r.School__r.Name).containsKey(Student.Class__r.Name))
                {
                    mapOfSchoolDetails.get(Student.Class__r.School__r.Name).get(Student.Class__r.name).add(Student.Name);
                }
                else
                {
                    mapOfSchoolDetails.get(Student.Class__r.School__r.Name).put(Student.Class__r.Name,new List<String>());
                }
            }
            else
            {
                Map<String,List<String>>mapofclassDetails=new Map<String,List<String>>();
                if(mapofclassDetails.get(Student.Class__r.Name)==null)
                {
                    mapofclassDetails.put(Student.Class__r.Name,new List<String>());
                }
                mapofclassDetails.get(Student.Class__r.Name).add(Student.Name);
                mapOfSchoolDetails.put(Student.Class__r.School__r.Name,mapofclassDetails);
            }
        }
        System.debug('--------------------->'+mapOfSchoolDetails);
        
        for(String str:mapOfSchoolDetails.KeySet())
        {
            for(String s:mapOfSchoolDetails.get(str).KeySet())
            {
                System.debug('--------------------->'+mapOfSchoolDetails.get(str).get(s));
            }
        }
    }
    
   public static void staticWayToDealCollections()
   {
       Map<String,Map<String,List<String>>>mapOfCoutryState=new Map<String,Map<String,List<String>>>
       {
           'India'=>
            new Map<String,List<String>>
           {
               'Rajasthan'=> new List<String>{'Udaipur','Jaipur'},
                   'Gujrat'=> new List<String>{'Ahmedabad','Surat'}
           },
           'USA'=>
           new Map<String,List<String>>
           {
               'New York'=> new List<String>{'new York 1','New York2'},
                   'Texas'=> new List<String>{'Texas1','texas2'}
           }
       };
           
       mapOfCoutryState.put('J&K', new Map<String,List<String>>{'Kulu'=>new List<String>{'Kulu1','kulu2'},'By'=>new List<String>{'k1','k2'}});
       
       List<String>lisofmore=new List<String>{'j1','k2','l3'};
       mapOfCoutryState.get('USA').put('WashingTon',lisofmore);
       
       mapOfCoutryState.get('India').get('Rajasthan').add('hi000000');
           
       //System.debug('----------Map---------->'+mapOfCoutryState);
       //System.debug('---------values----------->'+mapOfCoutryState.values());
       //System.debug('-----------Outer Key--------->'+mapOfCoutryState.keySet());
       //System.debug('--------Inner Key------------>'+mapOfCoutryState.get('India').values());
       //System.debug('--------Inner Key------------>'+mapOfCoutryState.get('India').get('Rajasthan'));
       //
       integer i=0;
       for(String str:mapOfCoutryState.keyset())
       {
          for(String instr:mapOfCoutryState.get(str).Keyset())
          {
               System.debug('----------->'+i+'------>'+mapOfCoutryState.get(str).get(instr));
          }
           i++;
       }
   }

}