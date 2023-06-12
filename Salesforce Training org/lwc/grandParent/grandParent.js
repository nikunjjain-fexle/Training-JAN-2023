import { LightningElement,api } from 'lwc';

export default class GrandParent extends LightningElement 
{
    
    constructor()
    {
        
        super();
        console.log('Grand Parent constructor');
    }
    connectedCallback()
    {

        console.log('Grand Parent connectedCallback');
    }
    renderedCallback()
    {
        console.log('Grand Parent renderedCallback');
    }
}