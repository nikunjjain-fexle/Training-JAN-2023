/**
*
*  Purpose          :   Apex class to have business logics related to "dataGrid" LWC component.
*
*  Created Date     :   12/07/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class DataGridController 
{
    @AuraEnabled(Cacheable=false)
    public static String doQuery(String objectName, String fieldsName, Integer limitValue) 
    {
        try
        {
            Map<String, String> returnMap = new Map<String,String>();
            if(String.isNotBlank(objectName)) 
            {
                if(String.isNotBlank(fieldsName)) 
                {
                    if(limitValue != null)
                    {
                        SOQLQueryWrapper sOQLQueryWrap = Utilities.buildSOQLQuery(objectName, fieldsName, limitValue, false, 
                                                                                  false, Constants.CHAR_BLANK,
                                                                                  Constants.CHAR_BLANK, Constants.CHAR_BLANK, Constants.CHAR_BLANK
                                                                                 );
                        if(sOQLQueryWrap != null) 
                        {
                            if(String.isNotBlank(sOQLQueryWrap.sOQLQuery)) 
                            {
                                if(sOQLQueryWrap.listOfGenericTableHeaderWrapper != null 
                                   && sOQLQueryWrap.listOfGenericTableHeaderWrapper.size() >0) 
                                {
                                    //prepare a map which will hold fields list and records List and return it
                                    returnMap.put(Constants.CHAR_FIELD_LIST, JSON.serialize(sOQLQueryWrap.listOfGenericTableHeaderWrapper));
                                    returnMap.put(Constants.CHAR_RECORD_LIST, JSON.serialize(Database.query(sOQLQueryWrap.sOQLQuery)));
                                    return JSON.serialize(returnMap);    
                                }
                                else 
                                {
                                    //Unable to return table header columns
                                    return null;    
                                }
                            }
                            else 
                            {
                                //Unable to return SOQL Query String
                                return null;
                            }
                        }
                        else 
                        {
                            //Invalid SOQL Query Object
                            return null;
                        }
                    }
                    else 
                    {
                        //Please specify the limit value
                        return null;
                    }
                }
                else 
                {
                    //Please specify the fields Name
                    return null;
                }
            } 
            else 
            {
                //Please specify the object Name
                return null;    
            }
        }
        catch(Exception ex) 
        {
            return null;
        }
    }    
}