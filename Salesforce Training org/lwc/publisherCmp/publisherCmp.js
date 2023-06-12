import { LightningElement,wire } from 'lwc';
import { fireEvent } from 'c/pubSubConnector';
import {CurrentPageReference} from  'lightning/navigation'; 
export default class PublisherCmp extends LightningElement 
{
    strText='';
    @wire(CurrentPageReference) objPageReference; 

    publishEvent(){ 
        
        fireEvent(this.objPageReference, 'EvenFromPub', this.strText); 

    }
    changeName(event)
    {
        
        this.strText=event.detail.value;
        console.log(this.strText);

    }
}