import { LightningElement,wire } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubSubConnector'; 

import { CurrentPageReference } from 'lightning/navigation'; 

export default class SubscribeCmp extends LightningElement 
{
   

    strCaputreText='';

    @wire(CurrentPageReference) pageRef; 

    connectedCallback() { 

        registerListener('EvenFromPub', this.setCaputreText, this); 

    } 

    disconnectedCallback() { 

        unregisterAllListeners(this); 

    } 

    setCaputreText(objectPayload){ 

        this.strCaputreText = objectPayload; 

    } 

}