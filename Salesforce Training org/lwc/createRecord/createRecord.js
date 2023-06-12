import { LightningElement,api, track } from 'lwc';

import contactRecMethod from '@salesforce/apex/CreationOfContactRecord.contactRecMethod'

import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';




export default class CreateRecord extends LightningElement 
{
    
    
 
    @api recordId;
    @track firstname = FIRSTNAME_FIELD;
    @track phone = PHONE_FIELD;
    @track email = EMAIL_FIELD;
    @track lastname = LASTNAME_FIELD;
    @track accountId =ACCOUNTID_FIELD;
    

    recContact = {
        
        FirstName : this.firstname,
        Phone : this.phone,
        Email : this.email,
        LastName: this.lastname,
        AccountId: this.accountId
    }
    connectedCallback()
    {
        //this.CreateRecordOfContact();
    }
    handelFistNamechange(event){
        this.recContact.FirstName = event.target.value;
        console.log("name",this.recContact.FirstName );
    }
    handelPhonechange(event){
        this.recContact.Phone = event.target.value;
       console.log("phone",this.recContact.Phone);
    }

    handelEmailchange(event){
        this.recContact.Email = event.target.value;
       console.log("email",this.recContact.Email );
    }

    handelLastNamechange(event){
        this.recContact.LastName = event.target.value;
        console.log("LastName",this.recContact.LastName );
    }


    CreateRecordOfContact()
    {
        alert(this.recContact.AccountId);
        this.recContact.FirstName = event.target.value;
        contactRecMethod({conRec: this.recContact}).then(result=>{
            this.message = result;
            this.error = undefined;
            alert(result);
            console.log('Result----',result);
            console.log('Data is Create ',this.message);
            if(this.message !== undefined) {
                this.recContact.FirstName = '';
                this.recContact.Email = '';
                this.recContact.Phone = '';
                this.recContact.LastName= '';
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact created',
                        variant: 'success',
                    }),
                );
            }
            
            console.log(JSON.stringify(result));
            console.log("result", this.message);
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            console.log("error", JSON.stringify(this.error));
        });
    }
}