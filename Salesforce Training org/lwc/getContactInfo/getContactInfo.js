import { LightningElement, api } from 'lwc';

import getContact from '@salesforce/apex/ContactsController.getContact'

const columns = [
    { label: 'Record Id', fieldName: 'Id' },
    { label: 'first name', fieldName: 'FirstName', type: 'Text' },
    { label: 'last name', fieldName: 'LastName', type: 'Text' },
    { label: 'Phone', fieldName: 'Phone', type: 'Text' },
    { label: 'Email', fieldName: 'Email', type: 'Text'},
    
];


export default class GetContactInfo extends LightningElement 
{
    @api recordId;
    contactList=[];
    colList = columns;

    connectedCallback()
    {
        this.getContactIn();
    }

    getContactIn() {
        getContact({
            accountId: this.recordId
        })
        .then(result => {
            this.contactList = result;
            console.log('data is' , result);
        })
        .catch(error => {
            console.log('error is ', error);
        });
    }
}