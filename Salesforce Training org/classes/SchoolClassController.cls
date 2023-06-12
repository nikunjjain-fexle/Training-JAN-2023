/*
 * Purpose      : Wrapper Class of Class And Students
 * 
 * Created By   : Nikunj Jain
 * 
 * Created Date : 20-05-2023
 * 
 * Version      : V_0.1
 * 
 * Story        : 
 */ 

public class SchoolClassController {
    
    // This Wrapper will be Execute  Get Record on invoked by Function
    @AuraEnabled(cacheable=false)
    public static ResponseWrapper getALLSchoolWithClass(String SchoolId)
    {
        List<ClassStudentListWrapper> schlWrapperList = new  List<ClassStudentListWrapper>();
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            
            
            List<Class__c> listOfClass = [SELECT Id,Name,Active__c,Board__c,CreatedById,LastModifiedById,(SELECT Id, Name, School_Name__c,Active_Student__c FROM Students__r) FROM Class__c WHERE School__c =:SchoolId];
            
            if(!listOfClass.isEmpty())
            {
                for(Class__c cl : listOfClass)
                {
                    ClassStudentListWrapper clsw = new ClassStudentListWrapper();
                    clsw.clRecord =cl;
                    clsw.listOfStudents = cl.Students__r;
                    clsw.sizeOfStudents =cl.Students__r.size();
                    schlWrapperList.add(clsw);
                }
                rw.setBody(schlWrapperList);
                
            }
        //return schlWrapperList;
        }
        catch(Exception ex)
        {
            rw.setError(ex.getMessage());
        }
        return rw;
    }
    
    public class ClassStudentListWrapper
    {
        @AuraEnabled
        public Class__c clRecord{get; set;}
        @AuraEnabled
        public List<Student__c> listOfStudents{get; set;}
        @AuraEnabled
        public integer sizeOfStudents{get; set;}
    }
    
    
    
    @AuraEnabled(cacheable=false)
    public static boolean deleteStudentRec(String studentId)
    {
        System.debug('studentId----'+studentId);
        List<Student__c> listOfDeleteStudent =[ SELECT Id FROM Student__c WHERE Id =:studentId ];
        
                    
        
            if(listOfDeleteStudent!=null)
            {
                System.debug('listOfDeleteStudent---'+listOfDeleteStudent);
                delete listOfDeleteStudent;
                return true;
            }
           
        System.debug('listOfDeleteStudent---'+listOfDeleteStudent);
        return false;
    }
    @AuraEnabled(cacheable=true)
    public static boolean updateRec(String recIds, Boolean checkBox)
    {
        System.debug('Yes inside method');
      
        System.debug('recIds'+recIds+'checkBox'+checkBox);
        if(String.isNotEmpty(recIds))
        {
            Student__c std= new Student__c();
            std.id=recIds;
            std.Active_Student__c=checkBox;
            update std;
            return true;
        }
        return false;
    }

}