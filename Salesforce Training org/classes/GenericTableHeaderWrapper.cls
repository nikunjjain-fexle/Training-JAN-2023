/**
*
*  Purpose          :   Apex Class to have the properties that is needed for the Generic Table Header columns.
*
*  Created Date     :   12/08/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class GenericTableHeaderWrapper 
{
    @AuraEnabled
    public String fieldLabel {get;set;}
    
    @AuraEnabled       
    public String fieldName {get;set;}
            
    @AuraEnabled
    public String fieldType {get;set;}
    
    public GenericTableHeaderWrapper() 
    {
    	fieldLabel = Constants.CHAR_BLANK;
        fieldName = Constants.CHAR_BLANK;
        fieldType = Constants.CHAR_BLANK;
    }
    
    public GenericTableHeaderWrapper(String fieldLabel, String fieldName, String fieldType)
    {
        this.fieldLabel = fieldLabel;
        this.fieldName = fieldName;
        this.fieldType = fieldType;          
    }
}