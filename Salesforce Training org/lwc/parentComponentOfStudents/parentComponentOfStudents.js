import { LightningElement, api } from 'lwc';
import getALLSchoolWithClass from '@salesforce/apex/SchoolClassController.getALLSchoolWithClass';
import deleteStudentRec from '@salesforce/apex/SchoolClassController.deleteStudentRec';
export default class ParentComponentOfStudents extends LightningElement {
    @api recordId;
    @api listAllRecords=[];
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
            console.log('data is' , result);
        })
        .catch(error=>{
            console.log('error is ', error);
        });
    }



    customEventDeleteByChildComp(event)
    {
        console.log('Yes im parent');
        //const recId =event.detail.Id;

        const recId = event.detail.Id;
        // Process the selected row data as needed
        console.log(recId);
       
       
        deleteStudentRec({
            studentId: recId
        })
        .then(result => {
            
            this.showToast('Success!!', 'Student Record deleted successfully!!', 'success', 'dismissable');
            //refreshApex(this.getClassAndStudentInfo());
            
            this.isLoading=true;
            window.location.reload;
        }).catch(error => {
            this.error = error;
        });
    }
}