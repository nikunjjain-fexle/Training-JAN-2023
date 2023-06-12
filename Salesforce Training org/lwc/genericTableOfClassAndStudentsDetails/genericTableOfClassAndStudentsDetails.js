import { LightningElement, api, track } from 'lwc';
import getALLSchoolWithClass from '@salesforce/apex/SchoolClassController.getALLSchoolWithClass';
import deleteStudentRec from '@salesforce/apex/SchoolClassController.deleteStudentRec';
import updateRec from '@salesforce/apex/SchoolClassController.updateRec';
import { refreshApex } from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
//import { NavigationMixin } from "lightning/navigation";
const columns = [
    { label: 'Student Name ', fieldName: 'Id', type : 'url' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Father Name', fieldName: 'Father_Name__c', type: 'text' },
    { label: 'Active std', fieldName: 'Active_Student__c', type: 'boolean', editable:true },
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

export default class GenericTableOfClassAndStudentsDetails extends LightningElement 
{
    @api recordId;
    @api listAllRecords=[];
    @api std=columns;
    @track error;
    isLoading=true;
    //isLoading=false;


    connectedCallback()
    {
        
        this.getClassAndStudentInfo();
        
    }
    getClassAndStudentInfo()
    {
        
        getALLSchoolWithClass({
            SchoolId:this.recordId
        })
        .then(result=>{
            
            this.listAllRecords=result.body;
            alert(JSON.stringify(result.body));
            console.log('data is' , result);
            
        })
        .catch(error=>{
            this.error=error;
            console.log('error is ', error);
        });
    }
    callRowAction(event) {
        const recId = event.detail.row.Id;
        const actionName = event.detail.action.name;
        if (actionName === 'Delete') {
            this.handleDeleteRow(recId); 
        }
        else if(actionName ==='Edit')
        {
            //this.handleSave(recId);
        }
    }
    handleDeleteRow(recId) {
        this.isLoading=false;
        deleteStudentRec({studentId: recId})
            .then(result => {
               
                this.showToast('Success!!', 'Student Record deleted successfully!!', 'success', 'dismissable');
                //refreshApex(this.getClassAndStudentInfo());
                
                this.isLoading=true;
                window.location.reload;
            }).catch(error => {
                this.error = error;
            }
        );
                
    }
    handleSave(event)
    {
        try
        {
            const rd  = event.detail.draftValues[0].Id;
            const val = event.detail.draftValues[0].Active_Student__c;
            console.log('Yes in Call');
        
        
        updateRec({recIds:rd ,checkBox:val})(result => {
            this.showToast('Success!!', 'Student Record deleted successfully!!', 'success', 'dismissable');
            window.location.reload();
            console.log('Yes after Reload page Call',result);
            
        }).catch(error => {
            this.error = error;
        });
        }
        catch(error)
        {
            alert(error.message);
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
}