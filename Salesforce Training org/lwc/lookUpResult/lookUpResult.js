import { LightningElement } from 'lwc';

export default class LookUpResult extends LightningElement 
{
    handleKeyPress()
    {
        console.log('handleKeyPress');
    }
    showPicklistOptions()
    {
        console.log('focus');
    }
}