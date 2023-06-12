import { LightningElement,api } from 'lwc';

const columns = [
    { label: 'Record Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Father Name', fieldName: 'Father_Name__c', type: 'text' },
    { label: 'Active std', fieldName: 'Active_Student__c', type: 'boolean', editable:true },
    {
        type: "button", label: 'Delete', initialWidth: 110, typeAttributes: {
            label: 'Delete',
            name: 'Delete',
            title: 'Delete',
            disabled: false, 
            value: 'delete',
            iconPosition: 'left',
            iconName:'utility:delete',
            variant:'destructive'
        }
    }
];

export default class childComponentOfStudent extends LightningElement {
    @api std=columns;
    @api getResultOfClassFromParent;

    callRowAction(event)
    {   
        const selection = new CustomEvent('markselect',{
            detail : {
      
                     'Id' : event.detail.row.Id,
                
            }}
                    
            )
            this.dispatchEvent(selection);
            
    }
    
    
}