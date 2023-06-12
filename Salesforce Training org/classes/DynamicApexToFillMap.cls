/*
 * Purpose       : Assessment Questions
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 28-04-2023
 * 
 * Revision Log  : V_1.0 Created 28/04/2023 
 *                 
 * 
 */ 

/*
Map 1 Key - Object API Name
Map 2 Key - Field Label
Map 3 Key - Field API Name 
Map 3 Value - Field Data Type

*/
public class DynamicApexToFillMap {
    
    public static void fillThemapOfObjcetDetails()
    {
        Map<String, Map<String, Map<String, String>>>  mapOfObjectDetails = new Map<String, Map<String, Map<String, String>>>();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        
      
        for(String s: schemaMap.KeySet())
        {
            if(schemaMap.get(s).getDescribe().isCustom())
            {
                Schema.SObjectType leadSchema = schemaMap.get(s);
                Schema.DescribeSObjectResult objResult = leadSchema.getDescribe();
                String objectlabel=objResult.getName();
    
                Map<String ,Map<String , String >> outerMapDetails = new Map<String ,Map<String , String >>();
                
                
                Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
                                
                for (String fieldName: fieldMap.keySet()) 
                {
                    if(fieldMap.get(fieldName).getDescribe().isCustom())
                    {
                        Map<String , String > innerMapDetails= new Map<String ,String>();
                        //fieldLabel=fieldMap.get(fieldName).getDescribe().getLabel();
                        Schema.DisplayType fielddataType = fieldMap.get(fieldName).getDescribe().getType();
                        //System.debug('@@@@ fielddataType: '+ String.valueOf(fielddataType));
                        innerMapDetails.put(fieldMap.get(fieldName).getDescribe().getName(),String.valueOf(fielddataType));
                        outerMapDetails.put(fieldMap.get(fieldName).getDescribe().getLabel(), innerMapDetails);
                    }
                }
                mapOfObjectDetails.put(objectlabel, outerMapDetails);
            }
			                          
        }
        System.debug('@@@@@ mapOfObjectDetails: '+mapOfObjectDetails);
        for(Map<String, Map<String, String>> ele: mapOfObjectDetails.values())
        {
            System.debug('@@@@'+ele);
        }
          
    // System.debug('@@@@@ mapOfObjectDetails: '+mapOfObjectDetails);
    }
}