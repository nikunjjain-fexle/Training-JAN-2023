import { LightningElement,api } from 'lwc';

export default class GrandChild extends LightningElement 
{
   

    constructor()
    {
        
        super();
        console.log(' Grand Child constructor');
    }
    connectedCallback()
    {
        console.log(' Grand Child connectedCallback');
    }
    renderedCallback()
    {
        console.log(' Grand Child renderedCallback');
    }
    disconnectedCallback()
    {
        console.log(' Grand Child DisconnectCallBack');
    }
}