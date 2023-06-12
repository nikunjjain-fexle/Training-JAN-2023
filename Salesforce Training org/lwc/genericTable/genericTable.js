/*
*
*  Purpose          :	Generic Table to display different object records using standard LWC table component JS.
*
*  Created Date     :  	12/07/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created - 12/07/2022
*
*/
import { LightningElement, api, track, wire } from 'lwc';

//Importing Constants
import {CHARACTERS, ELEMENT_TYPES, STATUS_MESSAGES} from 'c/constants';

//Importing Custom Events
import {CUSTOM_EVENTS} from 'c/customEvents';

//Importing Custom Events
import { listOfSplitedStrings } from './genericTableUtils.js';

// Importing labels
import wikipediaSearchURLPrefix from '@salesforce/label/c.WIKIPEDIA_SEARCH_URL_PREFIX';

//Importing Pagereference Navigation
import { NavigationMixin, CurrentPageReference } from 'lightning/navigation';

//Importing Utilities
import Utilities, {NotificationsUtilities, CustomEventsUtilities} from 'c/utilities';

import { fireEvent } from 'c/pubsub';

const UNEXPECTED_ERROR_WHILE_SAVE_MESSAGE = 'Unexpected error while save';

export default class GenericTable extends NavigationMixin(LightningElement)
{
    @wire(CurrentPageReference) pageRef;

    //Public Properties
    @api flexipageRegionWidth; //Property to hold the flexipage region width value (Record Page)
    @api columns = [];   //columns for List of fields datatable
    @api tableData = [];   //data for list of fields datatable
    
    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false
    }

    @track selectedRows = [];

    selectedRecordsNames = CHARACTERS.CHAR_COMMA;

    connectedCallback() 
    {
        this.state.initDone = true;
    }

    handleRowSelection(event) 
    {
        //Passing Selected Row Details
        let selectedRows = event.detail.selectedRows;

        if(selectedRows.length > 0)
        {
            let rowIndexes = CHARACTERS.CHAR_BLANK;
            let rows = [];

            for (let value of selectedRows) 
            {
                rowIndexes += CHARACTERS.CHAR_COMMA + this.tableData.findIndex(row => row.Id === value.Id);
                rows.push(this.tableData.find(row => row.Id === value.Id));
            }

            if(!Object.is(rows, null) && rows.length > 0 && !Object.is(rowIndexes, null)) 
            {
                rowIndexes = rowIndexes.replace(/^,/, CHARACTERS.CHAR_BLANK);

                let detailsObj =
                {
                    selectedRowNumbers : rowIndexes,
                    rows : rows
                };

                event.stopPropagation();

                //Custom Event --> (Child -- Parent)
                let cEvent = new CustomEventsUtilities();
                cEvent.fireCustomEvent(CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS, detailsObj, this);

                //Custom Event --> (All the siblings/components on the pages who have the respective handlers)
                fireEvent(this.pageRef, CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES, detailsObj);
            }
        }
        else 
        {
            let detailsObj = 
            {
                selectedRowNumbers : null,
                rows : null
            };

            //Custom Event --> (Child -- Parent)
            let cEvent = new CustomEventsUtilities();
            cEvent.fireCustomEvent(CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS, detailsObj, this);

            //Custom Event --> (All the siblings/components on the pages who have the respective handlers)
            fireEvent(this.pageRef, CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES, detailsObj);
        }    
    }

    goToWikipedia() 
    {
        let el = this.template.querySelector(ELEMENT_TYPES.ELEMENT_TYPE_LIGHTNING_DATATABLE);
        if(!Object.is(el, null)) 
        {
            let allSelectedRows = el.getSelectedRows();

            if(allSelectedRows.length > 0)
            {
                let recordNames = CHARACTERS.CHAR_BLANK;
                allSelectedRows.forEach(currentItem => 
                {
                    recordNames = recordNames + CHARACTERS.CHAR_COMMA + currentItem.Name;
                });

                this.selectedRecordsNames = recordNames.replace(/^,/, CHARACTERS.CHAR_BLANK);

                //Naviagate to Wikipedia Page
                Utilities.navigateToWebPage(wikipediaSearchURLPrefix, this.selectedRecordsNames, this);
            }
        }
    }

    popUpToastMessage()
    {
        NotificationsUtilities.showToastMessageNotification(STATUS_MESSAGES.ERROR_LOWERCASE ,
                            UNEXPECTED_ERROR_WHILE_SAVE_MESSAGE, 
                            STATUS_MESSAGES.ERROR_LOWERCASE); 
    }
    
    popUpAlertMessage()
    {
        NotificationsUtilities.showAlertMessageNotification(); 
    }
    
    popUpPromptMessage()
    {
        NotificationsUtilities.showPromptMessageNotification(); 
    }

    popUpConfirmMessage()
    {
        NotificationsUtilities.showConfirmMessageNotification(); 
    }

    @api
    updateSelection(selectedRowsNumber) 
    {
        if(!Object.is(selectedRowsNumber, null) && !Object.is(selectedRowsNumber, CHARACTERS.CHAR_BLANK)) 
        {
            if(!Object.is(this.tableData, null)) 
            {
                let selectedRowsIds = [];
                let rowsDetails = [];

                for (let rNumber of listOfSplitedStrings(selectedRowsNumber))
                {
                    if(!Object.is(this.tableData[rNumber], null)) 
                    {
                        selectedRowsIds.push(this.tableData[rNumber].Id);
                        rowsDetails.push(this.tableData[rNumber]);
                    }
                }

                if(!Object.is(selectedRowsIds, null) && selectedRowsIds.length > 0) 
                {
                    this.selectedRows = selectedRowsIds;

                    //https://salesforce.stackexchange.com/questions/294716/how-do-i-programatically-add-selected-rows-to-a-lwc-datatable
                    //Note the use of the spread syntax to duplicate the list to trigger @track and update the UI.
                    this.selectedRows = [...this.selectedRows];

                    if(!Object.is(this.selectedRows, null) && this.selectedRows.length > 0) 
                    {
                        let detailsObj =
                        {
                            selectedRowNumbers : selectedRowsNumber,
                            rows : rowsDetails
                        };

                        //Custom Event --> (Child -- Parent)
                        let cEvent = new CustomEventsUtilities();
                        cEvent.fireCustomEvent(CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS, detailsObj, this);

                        //Custom Event --> (All the siblings/components on the pages who have the respective handlers)
                        fireEvent(this.pageRef, CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES, detailsObj);
                    }
                }
            }
        }
        else 
        {
            let detailsObj = 
            {
                selectedRowNumbers : null,
                rows : null
            };

            this.selectedRows = [];

            //Custom Event --> (Child -- Parent)
            let cEvent = new CustomEventsUtilities();
            cEvent.fireCustomEvent(CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS, detailsObj, this);

            //Custom Event --> (All the siblings/components on the pages who have the respective handlers)
            fireEvent(this.pageRef, CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES, detailsObj);
        }
    }
}