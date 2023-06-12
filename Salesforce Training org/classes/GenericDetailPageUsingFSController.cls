/**
*
*  Purpose          :   Controller class for "GenericDetailPageUsingFS" VF Page.
                        Basically it is going to have server side needed code to build custom detail page on the basis of given id value in URL.
*
*  Created Date     :   11/29/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class GenericDetailPageUsingFSController 
{
    //Local variables
    List<String> listOfFieldSetNames;
    
    //Variables used on the VF page
    public Boolean displayFieldSetSections {get; set;}    
    public String formTitle {get; set;}
    public List<Schema.FieldSetMember> listOfFieldSet1FieldsDetails {get; set;}
    public List<Schema.FieldSetMember> listOfFieldSet2FieldsDetails {get; set;}
    public sObject sobjRecord { get; set; }
    
    public GenericDetailPageUsingFSController()
    {
        doInitialization();
        inIt();        
    }
    
    public void doInitialization() 
    {
        listOfFieldSetNames = new List<String>();
        listOfFieldSetNames = Utilities.getListOfValuesForCommaSeperateString(System.Label.GENERIC_DETAILS_PAGE_FIELD_SET_NAMES);
        
        displayFieldSetSections = false;  
        formTitle = Constants.CHAR_BLANK;
        listOfFieldSet1FieldsDetails = new List<Schema.FieldSetMember>();
        listOfFieldSet2FieldsDetails = new List<Schema.FieldSetMember>();
    }
    
    public void inIt() 
    {
        try 
        {
            String recordId = ApexPages.currentPage().getParameters().get(Constants.URL_PARAMETER_NAME_ID);
            
            //ID Parameter is missing or having null/blank as value
            if(String.isBlank(recordId)) 
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.ERROR_URL_PARAMETER_ID_MISSING));
                displayFieldSetSections = false;
            }
            else
            {
                //URL provided ID value is a valid salesforce record ID of some object
                if(Utilities.isaValidateSalesforceID(recordId)) 
                {
                    Schema.SObjectType sObjectType = Utilities.getObjectTypeOnBasisOfIdValue(recordId);
                    
                    if(sObjectType != null) 
                    {
                        //Object API Name (School__c)
                        String sObjectAPIName = Utilities.getSobjectAPIName(sObjectType);
                        
                        if(String.isNotBlank(sObjectAPIName)) 
                        {
                            formTitle = Utilities.getSobjectLabel(sObjectType) + ' Custom Detail Page';
                            
                            Boolean tempVarFieldSetExists = true;
                            String sOQLQueryFields = Constants.CHAR_BLANK;
                            Integer i = 0;
                            
                            //Loop through field set names
                            for(String fieldSetName : listOfFieldSetNames) 
                            {
                                List<Schema.FieldSetMember> fieldSetFieldsDetails = Utilities.readFieldSet(fieldSetName, sObjectAPIName);
                                
                                //Satisfies if field set with mentioned name exists on the particular object
                                if(fieldSetFieldsDetails.size() > 0) 
                                {
                                    sOQLQueryFields += Utilities.buildSOQLFieldsLiteralForTheFieldSet(fieldSetFieldsDetails);
                                }
                                else 
                                {
                                    tempVarFieldSetExists = false;    
                                }
                                
                                switch on i 
                                {
                                    when 0
                                    {
                                        listOfFieldSet1FieldsDetails = fieldSetFieldsDetails;
                                    }	
                                    when 1 
                                    {
                                    	listOfFieldSet2FieldsDetails = fieldSetFieldsDetails;    
                                    }
                                }
                                i++;
                            }
                            
                            //if any or both field sets doen't exists - add an error message on VF page
                            if(tempVarFieldSetExists == false) 
                            {
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Field Set Does not exists'));
                                displayFieldSetSections = false;
                            }
                            else 
                            {
                            
                                if(String.isNotBlank(sOQLQueryFields)) 
                                {
                                    sOQLQueryFields = sOQLQueryFields.trim();
                                    sOQLQueryFields = sOQLQueryFields.removeEnd(Constants.CHAR_COMMA);
                                }
                                
                                sobjRecord = getRecordDetails(sOQLQueryFields, sObjectAPIName, recordId);
                                if(sobjRecord != null) 
                                {
                                    displayFieldSetSections = true;    
                                }
                                else 
                                {
                                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Unable to retrieve record details'));
                                    displayFieldSetSections = false;
                                }
                            }
                        }
                        else 
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Invalid Object Name'));
                            displayFieldSetSections = false;
                        }
                    }
                    else 
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Invalid SObjectType')); 
                        displayFieldSetSections = false;
                    }
                }
                else
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.ERROR_INVALID_ID_VALUE));
                    displayFieldSetSections = false;
                }
            }
        }
        catch(Exception ex) 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
            displayFieldSetSections = false;
        }
    }
    
    private sObject getRecordDetails(String sOQLQueryFields, String objName, String recordId) 
    {
        String query = Constants.CHAR_BLANK;
        sObject sobj;
        
        if(String.isNotBlank(sOQLQueryFields) && String.isNotBlank(objName) && String.isNotBlank(recordId)) 
        {
            query = 'SELECT ' + sOQLQueryFields + ' FROM ' + objName + ' WHERE Id = :recordId';
            List<sObject> sObjList = Database.query(query);
            if(sObjList.size() > 0) 
            {
                return sObjList[0];
            }
        }
        return sobj;
    }
}