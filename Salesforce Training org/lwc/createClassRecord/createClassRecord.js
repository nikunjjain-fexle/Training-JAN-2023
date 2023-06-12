import { LightningElement, api } from 'lwc';

export default class CreateClassRecord extends LightningElement {
    @api recordId;

    createRecords(event)
    {
        this.showToast('Success!!', 'Class  Record Created successfully!!', 'success', 'dismissable');
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