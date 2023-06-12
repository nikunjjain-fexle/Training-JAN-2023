/*
*
*  Purpose          :	Data Grid to display Generic Table/Tiles/Kanban to display different object records and other related details.
*
*  Created Date     :  	25-05-2023
*
*  Created By       :  	Nikunj jain
*
*  Revision Logs    :  	V_1.0 - Created 
*
*/
import { LightningElement, api, track } from 'lwc';

//Importing Apex Classes
import doRecordsQuery from '@salesforce/apex/DataGridController.doQuery';

//Importing Constants
import { CHARACTERS, NUMBERS, DATA_TYPES, URL_TARGET_TYPES, ELEMENT_TYPES } from 'c/constants';

const LIGHTNING_URL_INITIAL_PREFIX = '/lightning/r/';
const LIGHTNING_URL_VIEW_SUFFIX = '/view';
const OVERALL_ALIGNMENT_STYLE_CLASS = 'slds-p-left_small slds-p-left_right';
const OVERALL_BORDER_STYLE_CLASS = 'container';
const DELAY_OF_2_SECOND = 2000;
const ICON_NAME_CUSTOM_40 = 'custom:custom40';
const ICON_NAME_ALTERNATIVE_TEXT = 'Custom Icon 40';

export default class DataGrid extends LightningElement
{
    //Public Properties
    @api objectName = CHARACTERS.CHAR_BLANK;
    @api fieldsName = CHARACTERS.CHAR_BLANK;
    @api limitValue = NUMBERS.NUMBER_ONE;
    @api firstColumnAsRecordHyperLink = CHARACTERS.CHAR_BLANK; //if the first column can be displayed as hyperlink
    @api flexipageRegionWidth; //Property to hold the flexipage region width value (Record Page)

    @api iconName = ICON_NAME_CUSTOM_40;
    @api iconTitle = CHARACTERS.CHAR_BLANK;
    @api headerTitle = CHARACTERS.CHAR_BLANK;
    @api headerSubTitle = CHARACTERS.CHAR_BLANK;

    @track columns;   //columns for List of fields of data grid
    @track dataGridData;   //data for list of fields data grid
    
    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false,
        error : null
    }

    //State variable to control rendering the HTML markup
    @track customDesignTokens =
    {
        alignmentStyles : OVERALL_ALIGNMENT_STYLE_CLASS,
        borderStyles : OVERALL_BORDER_STYLE_CLASS
    }

    selectedRowsNumber;
    alternativeText = ICON_NAME_ALTERNATIVE_TEXT;
    
    connectedCallback() 
    {
        this.handleSearch();
    }

     handleSearch() 
     {
        let firstTimeEntry = false;
        let firstFieldAPI;

        let { state } = this;

        //make an implicit call to fetch records from database 
        doRecordsQuery
        (
            { 
                objectName: this.objectName, 
                fieldsName: this.fieldsName, 
                limitValue: this.limitValue 
            }
        )
        .then((data) => 
        {
            //get the entire map
            let objStr = JSON.parse(data);   
            
            //retrieve listOfRecords from the map
            let listOfRecords = JSON.parse(Object.values(objStr)[0]);
            
            /* retrieve listOfFields from the map,
             here order is reverse of the way it has been inserted in the map */
            let listOfFields = JSON.parse(Object.values(objStr)[1]);

            let items = []; //local array to prepare columns

            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the first column with type = url
            */
            listOfFields.map(element=>
            {
                //it will enter this if-block just once
                if(this.firstColumnAsRecordHyperLink !== null && Object.is(this.firstColumnAsRecordHyperLink, CHARACTERS.CHAR_YES) && Object.is(firstTimeEntry, false))
                {
                    firstFieldAPI  = element.fieldName; 
                    
                    //perpare first column as hyperlink                                     
                    items = [...items,
                        {
                            label: element.fieldLabel,
                            fieldName: CHARACTERS.CHAR_URL_FIELD,
                            fixedWidth: 150,
                            type: DATA_TYPES.DATA_TYPE_URL, 
                            typeAttributes: 
                            { 
                                label: 
                                {
                                    fieldName: element.fieldName
                                },
                                target: URL_TARGET_TYPES.URL_TARGET_BLANK
                            },
                            sortable: true 
                        }
                    ];
                    firstTimeEntry = true;
                } 
                else 
                {
                    if(Object.is(element.fieldType, DATA_TYPES.DATA_TYPE_DOUBLE)) 
                    {
                        items = [...items , {label: element.fieldLabel, fieldName: element.fieldName, type: DATA_TYPES.DATA_TYPE_NUMBER, typeAttributes: { maximumFractionDigits: CHARACTERS.CHAR_ZERO }}];
                    }
                    else 
                    {
                        items = [...items , {label: element.fieldLabel, fieldName: element.fieldName}];
                    }
                }   
            });

            //finally assigns item array to columns
            this.columns = items; 
            this.dataGridData = listOfRecords;
            
            /*if user wants to display first column has hyperlink and clicking on the link it will
                naviagte to record detail page. Below code prepare the field value of first column
            */
            if(this.firstColumnAsRecordHyperLink !== null && Object.is(this.firstColumnAsRecordHyperLink, CHARACTERS.CHAR_YES)) 
            {
                let URLField;

                //retrieve Id, create URL with Id and push it into the array
                this.dataGridData = listOfRecords.map(item=>
                {
                    URLField = LIGHTNING_URL_INITIAL_PREFIX + this.objectName + CHARACTERS.CHAR_BACK_SLASH + item.Id + LIGHTNING_URL_VIEW_SUFFIX;
                    return { ...item, URLField };                     
                });

                //now create final array excluding firstFieldAPI
                this.dataGridData = this.dataGridData.filter(item => item.fieldName  != firstFieldAPI);
            }

            //assign values to display Object Name and Record Count on the screen
            this.recordCount = this.dataGridData.length;
            state.error = undefined;
        })
        .catch((error) =>
        {
            state.error = error;
            this.dataGridData = undefined;
        })
        .finally(() =>
        {
            setTimeout(() => 
            { 
                state.initDone = true;
            }, DELAY_OF_2_SECOND
            );
        });
    }

    //Child --> Parent (custom event)
    handleRowsSelectionEvent(event) 
    {
        if(event != null && event.detail != null) 
        {
            this.selectedRowsNumber = event.detail.selectedRowNumbers;
        }
    }

    handleRowNumberChange(e) 
    {
        this.selectedRowsNumber = e.detail.value;
    }

    //Parent --> Child (We are calling child component api type method)
    updateRowsSelection() 
    {
        this.template.querySelector(ELEMENT_TYPES.ELEMENT_TYPE_GENERIC_TABLE).updateSelection(this.selectedRowsNumber);
    }
}