/*
 * Purpose       : Write Apex Class Dyanmic Way to Deal with Collection 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 06-04-2023
 * 
 * Version       : V_0.1
 */


  
public Without Sharing class DyanmicWayToDealWithCollections {
    
 
    Map<String,Map<String,List<String>>>mapOfStudentRelatedList;
    
    public  DyanmicWayToDealWithCollections(){
        Map<String,Map<String,List<String>>>mapOfStudentRelatedList=new Map<String,Map<String,List<String>>>();
        
        for(Student__c str: [SELECT Id, Name, Class__r.Name, Class__r.School__r.Name FROM Student__c WHERE Class__r.Name !=null AND Class__r.School__r.Name !=null])
        {
            if(mapOfStudentRelatedList.containsKey(str.Class__r.School__r.Name)){
                if(mapOfStudentRelatedList.get(str.Class__r.School__r.Name).containsKey(str.class__r.Name))
                {
                    mapOfStudentRelatedList.get(str.Class__r.School__r.Name).get(str.class__r.Name).add(str.Name);
                }
                 else
                {
                    mapOfStudentRelatedList.get(str.Class__r.School__r.Name).put(str.Class__r.Name, new List<String>());
                }
               
            }
            else{
                
                Map<String,List<String>>mapOfClassWithStudent=new Map<String,List<String>>();
                if(mapOfClassWithStudent.get(str.Class__r.Name)==null)
                {
                    mapOfClassWithStudent.put(str.Class__r.Name,new List<String>());
                }
                mapOfClassWithStudent.get(str.Class__r.Name).add(Str.Name);
                mapOfStudentRelatedList.put(str.Class__r.School__r.Name,mapOfClassWithStudent);
            }
        }
        System.debug('@@@@-------'+mapOfStudentRelatedList);
        
        /*
        for(String s:mapOfStudentRelatedList.KeySet()){
            System.debug('@@@@-------'+mapOfStudentRelatedList.KeySet()));
        }*/
    }

}