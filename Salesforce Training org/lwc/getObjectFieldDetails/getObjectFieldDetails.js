import { LightningElement, api, track } from 'lwc';
import getOneObjectRecords from '@salesforce/apex/GetDetailToQuery.getOneObjectRecords';


export default class GetObjectFieldDetails extends LightningElement 
{
    @track  objectName;
    @track  fieldName;
    @track  limit;
    @track message=false;
    @track fieldListCommaSeperate;
    @track columns=[];
    finalGetRecords=[];

   
    handelFistNamechange(event){
        this.objectName = event.target.value;
        console.log("name",this.objectName);
        
    }
    getFieldName(event){
        this.fieldName = event.target.value;
        console.log("name",this.fieldName);
        
    }
    getLimit(event){
        this.limit = event.target.value;
        console.log("name",this.objectName);
        
    }
    

    updatecol()
    {
        this.fieldListCommaSeperate= this.fieldName.split(',').map(fieldName => fieldName.trim());
        const cl=[];
        this.fieldListCommaSeperate.forEach(fieldName=>{
            cl.push({label: fieldName, fieldName : fieldName, type: 'text'});
        });
        this.columns=cl;
    }


    getValueOfField()
    {
        
        getOneObjectRecords({objectApiName:this.objectName, fieldApiName:this.fieldName,recordsLimit:this.limit}
            ).then(result=>{
                this.finalGetRecords = result;
                console.log('result',result)
                this.updatecol();
                console.log('message',this.message);
                this.message = true;
                console.log('yes call', result);
                console.log('message',this.message);

                if(this.message === true) {
                    this.objectName='';
                    this.fieldName='';
                    this.limit='';
                    
                }
                
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