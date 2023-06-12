/*
 * Purpose      : Class to have With/Without Sharing Based concepts demonstration
 * 
 * Created By   : Nikunj jain
 * 
 * Created Date : 27-3-2023
 * 
 * Version :
 */

public class playingWithSharingRule {
    
    private School__c school;    
    public playingWithSharingRule(ApexPages.StandardController stdController){ 
        
        this.School = (School__c)stdController.getRecord();
        List<School__c>schools = [SELECT ID, Name FROM School__c];
        
        System.debug('@@@@@'+schools);
    }
    public  playingWithSharingRule(){
        List<School__c>schools=[SELECT ID, Name FROM School__c];
        
        System.debug('@@@@@'+schools.size());
        
    }
}