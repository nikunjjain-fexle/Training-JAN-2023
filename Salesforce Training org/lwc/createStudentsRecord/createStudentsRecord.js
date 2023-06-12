import { LightningElement, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class CreateStudentsRecord extends LightningElement {
    @api recordId;

    createRecords(event)
    {
        this.showToast('Success!!', 'Student Record Created successfully!!', 'success', 'dismissable');
        window.location.reload();
        return;
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