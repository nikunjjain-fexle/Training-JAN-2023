/**
*
*  Purpose          :   Class to have the methods to create/update custom metadata type records.
						https://andyinthecloud.com/2017/08/29/introducing-custom-metadata-services/
*
*  Created Date     :   11/16/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class CreateUpdateCustomMetadataTypeHandler 
{
    public static String saveHTTPCalloutConfigurationHandler(String metadataRecordDeveloperName) 
    {
        String deployId = Constants.CHAR_BLANK;
        String deployResult = Constants.CHAR_BLANK;
        
        if(String.isNotBlank(metadataRecordDeveloperName)) 
        {
            List<HTTPCalloutConfiguration__mdt> httpCalloutConfigRecords = [SELECT DeveloperName, Label, Timeout__c
                                                                            FROM HTTPCalloutConfiguration__mdt
                                                                            where DeveloperName =: metadataRecordDeveloperName];
            if(httpCalloutConfigRecords.size() > 0) 
            {
                HTTPCalloutConfiguration__mdt httpCalloutConfigRecord = httpCalloutConfigRecords[0];
                httpCalloutConfigRecord.Timeout__c = 11000;
                
                DeployId = 
                    CustomMetadata.Operations
                    .callback
                    (
                        MetadataDeployment__e.getSObjectType(),
                        MetadataDeployment__e.DeploymentId__c, 
                        MetadataDeployment__e.Result__c
                    )
                    .enqueueUpsertRecords
                    (
                        new List<SObject> { httpCalloutConfigRecord }
                    )
                    .deployId;
            } 
        }
        return deployId;
    }
}