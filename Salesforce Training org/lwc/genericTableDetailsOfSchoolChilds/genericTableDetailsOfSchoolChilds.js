/*
 * Purpose       : JS For School Child Record Show on Table
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 19-05-2023
 * 
 * Revision Log  : V_1.0 Created  19-05-2023
 *               : V_1.1 Modified By nikunj jain 20-05-23 Add delete Functionality
 *               : V_1.2 Modified By nikunj jain 20-05-23 Add Edit Functionality
 *               : V_1.2 Modified By nikunj jain 29-05-23 Add Stencil Functionality
 */ 


import { LightningElement, api, track } from 'lwc';
import getClassName from '@salesforce/apex/ClassController.getClassName'
import { updateRecord } from 'lightning/uiRecordApi';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import massDeleteRec from '@salesforce/apex/ClassController.massDeleteRec';
import updateStudents from '@salesforce/apex/ClassController.updateStudents';
import LightningConfirm from 'lightning/confirm';

//import massUpdateRec from '@salesforce/apex/MassDelete.massUpdateRec';
//import { NavigationMixin } from 'lightning/navigation';

const columns = [
    { label: 'Record Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text', editable: true },
    { label: 'Father Name', fieldName: 'Father_Name__c', type: 'text', editable: true },
    { label: 'Active std', fieldName: 'Active_Student__c', type: 'boolean', editable: true },
    {
        type: "button", label: 'Delete', initialWidth: 110, typeAttributes: {
            label: 'Delete',
            name: 'Delete',
            title: 'Delete',
            disabled: false,
            value: 'delete',
            iconPosition: 'left',
            iconName:'utility:delete',
            variant:'destructive'
        }
    }
    
];
export default class GenericTableDetailsOfSchoolChilds extends LightningElement 
{
    
    @api listOfClass=[];
    @api recordId;
    std=columns;

    // List
    draftValues = [];

    // Map
   collectionsOfRowDetails = {};

   //State variable to control rendering the HTML markup
   @track state =
   {
       initDone : false
   }
    

    @track recordsCount = 0;
    @track updateRecordsCount =0;
    @track isTrue = true;
    @track buttonLabel = 'Delete Mass Students'; 
    @track buttonLabelUpdate='Update Mass Students';
    @track isUpdateTrue=true;
    @track selectedUpdateRecords=[];

    listOfUpdatedStudentsRecord={};
    selectedRecords = [];
    finallList=[];
    


    // Constructor
    connectedCallback()
    {
        // get Class and Students
        this.getClassInfo();
        
    }

    getClassInfo() {
        getClassName({
            SchoolId: this.recordId
        })
        .then(result => {
            this.listOfClass = result;
            this.resultTable=result;
            
            console.log('data is' , result);
        })
        .catch(error => {
            console.log('error is ', error);
        })
        .finally(()=>{
            this.state.initDone=true;
        });
    }

    callRowAction(event) {
        const recId = event.detail.row.Id;
        const actionName = event.detail.action.name;
         if (actionName === 'Delete') {
            this.handleDeleteRow(recId);
         }
         else
         {
            alert('Yes call');
            this.getRowEditDetails(event);
         }
         
    }
    getRowEditDetails()
    {
        
        this.isUpdateTrue = false; 
        
        const rowId = event.detail.draftValues[0].Id;
        const rowValues = event.detail.draftValues[0].Father_Name__c;
        this.collectionsOfRowDetails={
            ['Id']:rowId,
            ['Father_Name__c']:rowValues
        }
       // this.collectionsOfRowDetails.set(rowId,rowValues);
        this.finallList.push(this.collectionsOfRowDetails);
        console.log('List.....',JSON.stringify(this.finallList));
        
        
    }
    
    handleDeleteRow(recordIdToDelete) {
        deleteRecord(recordIdToDelete)
            .then(result => {
                this.showToast('Success!!', 'Student Record deleted successfully!!', 'success', 'dismissable');
                return refreshApex(this.getClassInfo());
            }).catch(error => {
                this.error = error;
            }
        );
    }
    

    async handleSave(event) {
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });

        // Clear all datatable draft values
        this.draftValues = [];

        try {
            // Update all records in parallel thanks to the UI API
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);

            // Report success with a toast
            this.showToast('Success!!', 'Student Record updated successfully!!', 'success', 'dismissable');
            
            // Display fresh data in the datatable
            await refreshApex( this.getClassInfo());
            //return refreshApex(this.refreshTable);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading contacts',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }

    showToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    getSelectedRecords(event) {   
        this.isTrue = false;     
        const selectedRows = event.detail.selectedRows;
        this.recordsCount = event.detail.selectedRows.length;
        
        //alert(JSON.stringify(event.detail));
        //alert(JSON.stringify(event.target));
        //alert(JSON.stringify(event.detail.selectedRows[0].Father_Name__c));
        this.selectedRecords=new Array();
        for (let i = 0; i < selectedRows.length; i++) {
            this.selectedRecords.push(selectedRows[i]);
        }
        console.log('Yes in side selection Row',this.selectedRecords);
        
        
    }
    async handleConfirmClick() {
        
         const finalResult = await LightningConfirm.open({
            message: 'Are you Sure to delete Mass Records',
            variant: 'headerless',
            label: 'this is the aria-label value',
            
            
        })
        if(finalResult)
        {
            this.massDelete();
        }
        else{
            this.isTrue = true;
            return refreshApex(this.getClassInfo());   
        }
       
            
    }
    async handleConfirmOnUpdateClick() {
        
        const finalResult = await LightningConfirm.open({
           message: 'Are you Sure to Update Mass Records',
           variant: 'headerless',
           label: 'this is the aria-label value',
           
       }).then(result=>{
           this.massUpdate();
       });
      
           
   }
   

    massDelete()
    {
            if(this.selectedRecords.length>0)
            {
                
                this.buttonLabel = 'Processing....';
                
                    massDeleteRec({listofStd: this.selectedRecords}).then(result => {
                        this.showToast('Success!!', this.recordsCount +'  Students Record deleted successfully!!', 'success', 'dismissable');
                        this.buttonLabel = 'Delete Mass Students';
                        this.isTrue = false;
                        this.recordsCount = 0;
                        
                        return refreshApex(this.getClassInfo());

                        
                    }).catch(error => {
                        this.error = error;
                    });  
            }
            else{
                alert('Please Select Deleted Records');
            }   
    }
    massUpdate()
    {
       
            if(this.finallList.length>0)
            {
                console.log('Map Results',this.collectionsOfRowDetails);
                console.log('Map Results',this.listOfUpdatedStudentsRecord);
                this.buttonLabelUpdate = 'Processing....';
                
                updateStudents({mapOfStudents:  this.finallList}).then(result => {
                    this.showToast('Success!!', this.recordsCount +'  Students Record Updated successfully!!', 'success', 'dismissable');
                    this.buttonLabelUpdate = 'Update Mass Students';
                    this.isUpdateTrue  = true;
                    this.updateRecordsCount = 0;
                    
                    return refreshApex(this.getClassInfo());

                    
                }).catch(error => {
                    this.error = error;
                });
                
            }
            else{
                alert('Please Select Update Records');
            }
        
    }
    

}

/*
Some Extra Functionality Lightning-datatable for Button
{
        type: "button", label: 'View', initialWidth: 100, typeAttributes: {
            label: 'View',
            name: 'View',
            title: 'View',
            disabled: false,
            value: 'view',
            iconPosition: 'left',
            iconName:'utility:preview',
            variant:'Brand'
        }
    },
    {
        type: "button", label: 'Edit', initialWidth: 100, typeAttributes: {
            label: 'Edit',
            name: 'Edit',
            title: 'Edit',
            disabled: false,
            value: 'edit',
            iconPosition: 'left',
            iconName:'utility:edit',
            variant:'Brand'
        }
    },



    callRowAction(event) {
        const recId = event.detail.row.Id;
        const actionName = event.detail.action.name;
        if (actionName === 'Edit') {
            this.handleAction(recId, 'edit');
        } else if (actionName === 'Delete') {
            this.handleDeleteRow(recId);
        } else if (actionName === 'View') {
            this.handleAction(recId, 'view');
        }
    }
    handleAction(recordId, mode) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Account',
                actionName: mode
            }
        })
    }


    this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading contacts',
                    message: error.body.message,
                    variant: 'error'
                })
            );
*/