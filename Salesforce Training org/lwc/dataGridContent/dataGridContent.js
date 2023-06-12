/*
*
*  Purpose          :	LWC component to display Data Grid - Content - JS file.
*
*  Created Date     :  	26-05-2023
*
*  Created By       :  	Nikunj jain
*
*  Revision Logs    :  	V_1.0 - Created 
*
*/
import { LightningElement, api, track } from 'lwc';

export default class DataGridContent extends LightningElement 
{
    //Public Properties
    @api flexipageRegionWidth;
    @api objectName;
    @api fieldsName;
    @api limitValue;
    
    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false
    }

    connectedCallback() 
    {
        this.state.initDone = true;
    }
}