import { LightningElement, api,track } from 'lwc';

// Important Constants
import {CHARACTER,NUMBERS} from 'c/constants';

import getAllObject from '@salesforce/apex/GetDetailToQuery.getOneObjectRecordsDetails';
import getObjectDetailsOnKeyPress from '@salesforce/apex/GetDetailToQuery.getObjectDetailsOfOnKeyPress';
import Name from '@salesforce/schema/Account.Name';

export default class LookUp extends LightningElement 
{
    @api objectName='';
    @api LimitValue='';
    @api searchData;
    @api iconName = '';
    @api visibleOnPill='';
    @api visibleOffPill='';
    @api isShow=false;
    @api isFullScreen=false;
    @track selectedPillValue='';
    @track listOfObject=[];
    @track listOfResult =[];
    @track resultOfObject=[];

    
    connectedCallback()
    {
        
        this.getObjectInfo();
        this.updateIconName();
    }

    updateIconName() {
        this.iconName = 'standard:' + this.objectName.toLowerCase();
        
      }
    getObjectInfo()
    {
        let finalQuery='SELECT Id, Name FROM '+this.objectName+' '+' LIMIT '+this.LimitValue;
        getAllObject({
            dynamicQuery:finalQuery
        })
        .then(result=>{
            console.log('result-->',result)
            this.visibleOffPill=true;
            this.listOfResult=result;
            this.listOfObject = result;

              
        })
        .catch(error => {
            console.log('error is ', error);
        })
   
    }
    getDetailOfObjectOnChangeInfo()
    {
        
        getObjectDetailsOnKeyPress({
            searchInput: this.searchData,
            objectApiName : this.objectName
        })
        .then(result=>{
            console.log('result-->',result)
            
            this.resultOfObject = result;


                
        })
        .catch(error => {
            console.log('error is ', error);
        })

    }
    getOldGotResult()
    {
        this.resultOfObject=this.listOfResult;
    }
    selectRecord()
    {
        this.visibleOnPill=false;
        this.visibleOffPill=true;
    }

    showPicklistOptions(event)
    {
        this.isShow=true;
        this.resultOfObject= this.listOfObject;
    }
    selectSearchResult(event) {
        alert(event.currentTarget.dataset.name);
        alert(event.currentTarget.dataset.recid);
        const selectedValue = event.currentTarget.dataset.name;
        console.log('@@@ selectedValue : '+JSON.stringify(selectedValue));
        this.selectedPillValue = selectedValue;
        this.resultOfObject=[];
        this.isShow=false;
        // Additional logic or actions based on the selected value
      }
    handleOnSearch(event)
    {
        this.searchData = event.detail.value;
        
        if(this.searchData.length>=2)
        {
            this.getDetailOfObjectOnChangeInfo();
        }
        else
        {
            this.getOldGotResult();
        }
        
        
    }
    handleOnCreateRecord()
    {
        this.isShow=false;
        this.isFullScreen=true;
    }
    handleBlur(event)
    {
        this.resultOfObject=[];
    }
    
}