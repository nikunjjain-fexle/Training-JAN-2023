import { LightningElement,track } from 'lwc';

export default class Parent extends LightningElement 
{
    showGrandChildComp=true;
    constructor()
    {
        super();
        console.log(' Parent constructor');
    }
    connectedCallback()
    {
        console.log(' Parent connectedCallback');
    }
    renderedCallback()
    {
        console.log(' Parent renderedCallback');
    }
    handleOnClickDeleteGrand()
    {
        this.showGrandChildComp=false;

    }

}