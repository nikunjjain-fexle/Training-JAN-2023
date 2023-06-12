/*
*
*  Purpose          :	LWC component to display Generic Page Header JS file.
*
*  Created Date     :  	12/07/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created - 12/07/2022
*
*/
import { LightningElement, api, track } from 'lwc';

export default class GenericPageHeader extends LightningElement 
{
    //Public Properties
    @api flexipageRegionWidth;
    @api iconName;
    @api alternativeText;
    @api iconTitle;
    @api headerTitle;
    @api headerSubTitle;
    
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