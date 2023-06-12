import { LightningElement, api, track } from 'lwc';
import getAllObject from '@salesforce/apex/GetReportOfUserDetailsController.getDetails';
import getFieldsDetails from '@salesforce/apex/GetReportOfUserDetailsController.getFieldsDetails';
import getFieldDataType from '@salesforce/apex/GetReportOfUserDetailsController.getFieldDataTypeDetails';
import getRecords from '@salesforce/apex/GetReportOfUserDetailsController.getRecordOnUserInput';
import getPickListValues from '@salesforce/apex/GetReportOfUserDetailsController.getPickListValuesIntoList';

//Importing Utilities
import Utilities, {NotificationsUtilities, CustomEventsUtilities} from 'c/utilities';

const operator = [
    {
        label: 'STRING', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Like', value: 'LIKE' },
            
        ]
    },
    {
        label: 'BOOLEAN', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' }
            
        ]
    },
    {
        label: 'ID', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            
        ]
    },
    {
        label: 'DATE', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
        ]
    },
    {
        label: 'PERCENTAGE', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
        ]
    },
    {
        label: 'NUMBER', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
        ]
    },
    {
        label: 'INTEGER', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
        ]
    },
    {
        label: 'DOUBLE', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
        ]
    },
    {
        label: 'REFERENCE', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            
        ]
    },
    {
        label: 'PICKLIST', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' }
            
        ]
    },
    {
        label: 'DATETIME', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
            
        ]
    },
    {
        label: 'CURRENCY', value: [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Less Than', value: '<' },
            { label: 'Less or Equal', value: '<=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Greater or Equal', value: '>=' }
            
        ]
    }
];



export default class CreateReportOfUserData extends LightningElement 
{
    @api statusOptions=[];
    @api objectApi='';
    @api selectedFieldDataType;
    @api fieldSelectValue=[];
    @api opertaorList=[];
    @api fieldValues;
    @api amountDataType;
    @api booleanDataType;
    @api pickListresult;
    @api condition;
    @api isCondition=false;
    //@api AddRow=false;
    
    @track fieldName;
    @track fieldListCommaSeperate;
    @track finalQuary=[];
    @track dataTypes=[];
    @track fieldSelectValueApex=[];
    @track limit;
    @track listOptions=[];
    @track columns=[];
    @track isPickList=false;
    @track pickistDataTypes;
    @track comboxofAddFilter = []; 
    @track whereconditions;
    @track isClearFilter=true;
    @track isGetRecord=true;
    @track isConditionRequired=false;
    @track isLastValue=false;
    @track isConditionOnMoreThanOn=false;
    @track isVisibleAddFilterButton=false;
    @track isVisibleAddLimitButton=false;
    @track isOnRevomeField=false;
    @track isVisibleDataTable=false;
    @track isLoading=false;
    @track isVisibleCustomInput=false;
    @track isSuccess;
    @track isVisibleClearAll;
    @track customConditionUserInput=[];
    //@track index = 0;

    finalGetRecords=[];
   
    get listOfConditions () { 
        return [
        { label: 'AND', value: 'AND' },
        { label: 'OR', value: 'OR' },
        { label: 'Custom Conditions', value: true }
      ];
    }

     //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false
    }
    connectedCallback()
    {
        this.getObjectInfo();
    }
    
    addRow(){

        this.isGetRecord=true;
        const newFilter = {
            
            field: '',
            operators: [],
            value: '',
            pickListValues:[],
            isPickList:'',
            conidtion:'',
            dataType:'',
            index:'',
            label:''
                     
        };
        
        this.comboxofAddFilter.push(newFilter);
        this.pickListresult='';
        this.whereconditions='';
        console.log('add ',JSON.stringify(this.comboxofAddFilter));
        if(this.comboxofAddFilter.length===2)
        {
            this.isCondition=true;
            this.isClearFilter=false;
            this.isGetRecord=true;
            this.isConditionOnMoreThanOn=true;
        }
        else if(this.comboxofAddFilter.length===1)
        {
            this.isGetRecord=true;
        }
        

    }
    removeRow(){

        const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        console.log('Before Remove ',JSON.stringify(this.comboxofAddFilter));
        if(this.comboxofAddFilter.length>0)
        {
            this.comboxofAddFilter.splice(index);
            if(this.comboxofAddFilter.length==1)
            {
                this.isCondition=false;
                this.isConditionOnMoreThanOn=false;
                this.isVisibleCustomInput=false;
                
            }
            
        }
        if(this.comboxofAddFilter.length===0)
        { 
           
            this.isCondition=false;
            this.isConditionOnMoreThanOn=false;
            this.isGetRecord=false;
        }
        console.log('After Remove ',JSON.stringify(this.comboxofAddFilter));
           

        
    }
    clearAllFilter()
    {
        //const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        this.comboxofAddFilter=[];
        if(this.comboxofAddFilter.length==0)
        {
            this.isClearFilter=true;
            this.isConditionOnMoreThanOn=false;
            this.isCondition=false;
            this.isGetRecord=false;
            this.whereconditions='';
            this.isVisibleCustomInput=false;
            
        }
        this.isVisibleCustomInput=false;
        this.customConditionUserInput=[];
        
        
        

    }
    clearAllGoted()
    {
        this.isGetRecord=true;
        this.customConditionUserInput=[];
        this.comboxofAddFilter=[];
        this.objectApi='';
        this.fieldSelectValue=[];
        this.selectedFieldDataType='';
        this.fieldValues='';
        this.pickListresult='';
        this.limit='';
        this.condition='';
        this.columns=[];
        this.isCondition=false;
        this.isVisibleAddFilterButton=false;
        this.isVisibleAddLimitButton=false;
        this.isVisibleAfterAddInputBoxButton=false;
        this.isConditionOnMoreThanOn=false;
        this.isVisibleCustomInput=false;
        this.finalGetRecords=[];
        this.listOptions=[];
        this.isVisibleClearAll=false;
        

    }
    addLimit()
    {
        this.isVisibleAddLimitButton=true;
        this.isVisibleAfterAddInputBoxButton=false;
    }

    getObjectInfo()
    {
        getAllObject({

        })
        .then(result=>{
            console.log('ALL Object Result',result.body)
            this.statusOptions=(result.body).map(obj=>{
                return {label:obj, value:obj}
            })

        })
        .catch(error => {
            console.log('error is ', error);
        })
        .finally(()=>{
            this.state.initDone=true;
        });
        
    }
    getAllFeildDetailOfObject()
    {
        getFieldsDetails({
            objectName:this.objectApi
        })
        .then(result=>{
            console.log('Field Result ',result.body);
            this.listOptions=(result.body).map(obj=>{
                return {label:obj, value:obj}
            })
        })
        .catch(error => {
            console.log('error is ', error);
        });
        
    }
    
    getFieldsDataTypes(index)
    {
        getFieldDataType({
            objectName:this.objectApi,  
            selectedFields:this.selectedFieldDataType
        })
        .then(result=>{
            console.log('Data type '+result.body); 

            const entry = operator.find(item => item.label === result.body).value;
            const opp = [];

            entry.forEach(option => {
            opp.push({ label: option.label, value: option.value });
            });

            this.comboxofAddFilter[index].operators = opp.map(name => ({
            label: name.label,
            value: name.value
            }));

            console.log(JSON.stringify(this.comboxofAddFilter));
            if(result.body==='PICKLIST')
            {
                this.pickistDataTypes=result.body;
                this.comboxofAddFilter[index].isPickList=true;
                this.comboxofAddFilter[index].dataType='PICKLIST';
            } 
            else if(result.body==='BOOLEAN')
            {
                this.comboxofAddFilter[index].isPickList=false;
                this.booleanDataType=result.body;
                this.comboxofAddFilter[index].dataType='CHECKBOX';
            }
            else if(result.body==='CURRENCY')
            {
                this.comboxofAddFilter[index].isPickList=false;
                this.amountDataType=result.body;
                this.comboxofAddFilter[index].dataType='CURRENCY';
            }
            else
            {
                this.comboxofAddFilter[index].isPickList=false;
                this.comboxofAddFilter[index].dataType=result.body;
            }


            
        })
        .catch(error => {
            console.log('error is ', error);
        });
    }
    getReport()
    {
        let fieldsDetails = JSON.stringify(this.fieldSelectValueApex);
        console.log('@@@',JSON.stringify(this.comboxofAddFilter));
        console.log('@@@ condition', this.condition);
        console.log('@@@this.objectApi ', this.objectApi);
        console.log('@@@ limit ', this.limit);
        
        console.log('@@@ fieldsDetails : ',JSON.stringify(this.fieldSelectValueApex));
        
        getRecords({
            dynamicFieldsQuery : this.comboxofAddFilter,
            conditions: this.condition,
            selectedField : fieldsDetails,
            selectedObjectName : this.objectApi,
            recordLimit : this.limit,
            customeConditions :this.customConditionUserInput
            
        }).then(result=>{
            console.log('Final result',result);
            this.finalGetRecords = result.body;
            this.isVisibleDataTable=true;
            this.isSuccess=result.isSuccess;
            console.log('isSuccess',this.isSuccess);
            this.errorMessage=result.msg;
            console.log('errorMessage', this.errorMessage);
            //alert(this.isSuccess);
            //alert(this.errorMessage);
            this.updatecol();
        })
        .catch(error => {
            alert(error);
            console.log('error is ', error);
            this.isVisibleDataTable=false;
        });
    }

    updatecol()
    {
        
        
            this.fieldListCommaSeperate= this.fieldSelectValue;
            const cl=[];
        
            this.fieldListCommaSeperate.forEach(fieldName=>{
               
                cl.push({label: fieldName, fieldName : fieldName, type: 'text'});
            });
            this.columns=cl;
            this.isLoading=true;
            if(this.isSuccess===true && this.finalGetRecords.length>0)
            {
                this.isGetRecord=false;
                NotificationsUtilities.showToastMessageNotification('Record is Successfully','  ','Success ');
            }
            if(this.isSuccess===true && this.finalGetRecords.length===0)
            {
                NotificationsUtilities.showToastMessageNotification('No Record','  ','Success ');
                this.isVisibleDataTable=false;
                this.isGetRecord=false;
            }
            else if(this.isSuccess===false)
            {
                NotificationsUtilities.showAlertMessageNotification(this.errorMessage,'error','Error!');
                this.isVisibleDataTable=false;
                this.isGetRecord=false;
            }
            
       
    }


    /* Onchange Event Method */

    // on Selection of object
    handleChangeOnSelectObject(event) {
       
        this.objectApi = event.detail.value;
        this.getAllFeildDetailOfObject(this.value);
        this.fieldSelectValue=[];
    }
    // on Selection of Field
    hanldeChangeOnSelectField(event)
    {
        this.fieldSelectValue=event.detail.value;
        this.isGetRecord=false;
        this.isVisibleAddFilterButton=true;
        this.isVisibleAfterAddInputBoxButton=true;
        this.isOnRevomeField=false;
        this.isVisibleClearAll=true;
        
        this.fieldSelectValueApex=event.detail.value;
        if( this.fieldSelectValue.length===0)
        {
            this.isGetRecord=true;
            this.isVisibleAddFilterButton=false;
            this.isOnRevomeField=true;
            this.isVisibleAddLimitButton=false;
        }
        if(this.isVisibleAddLimitButton===true)
        {
            this.isVisibleAfterAddInputBoxButton=false;
        }
        
    }

    // on Selection of Field in where Case
    hanldeChangeOnWhereclause(event)
    {
        
        this.selectedFieldDataType=event.detail.value;
        //alert(this.selectedFieldDataType);
        // recently add
        
        const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        
        this.getFieldsDataTypes(index);

        
        
        console.log('@@@@ '+index);  
        this.comboxofAddFilter[index].field =  this.selectedFieldDataType;
        this.comboxofAddFilter[index].index =  index;
        
        console.log('Field ',JSON.stringify(this.comboxofAddFilter));
        

    }
    // on Selected Operator
    hanldeChangeOnWhereSelect(event)
    {
        this.whereconditions=event.detail.value;
        
        const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        console.log('@@@@ '+index);
        this.comboxofAddFilter[index].operator = event.detail.value;
        this.comboxofAddFilter[index].index =  index;
        console.log('Field ',JSON.stringify(this.comboxofAddFilter));
        
        console.log('whereconditions ',JSON.stringify(this.comboxofAddFilter));
        if(this.pickistDataTypes==='PICKLIST')
        {
            this.isPickList=true;
            getPickListValues({
                objectName: this.objectApi,
                selectedFields:this.selectedFieldDataType
            })
            .then(result=>{
                console.log('ALL pickListresult ',result.body);
                this.comboxofAddFilter[index].pickListValues = Object.entries(result.body).map(([key, value]) => ({
                    label: key,
                    value: value
                }));
                console.log(JSON.stringify(this.comboxofAddFilter));
    
            })
            .catch(error => {
                console.log('error is ', error);
            });
        }
        
    }
    // on Enter values
    handleOnChangeValue(event)
    {
        //this.isGetRecord=false;
        if(this.comboxofAddFilter.length===1)
        {
            this.isGetRecord=false;
        }
        if(this.comboxofAddFilter.length>=2)
        {
            if(this.isConditionRequired===true)
            {
                this.isGetRecord=false;
            }
            else
            {
                this.isLastValue=true;
            }
        }
        if(event.target.checked)
        {
            this.fieldValues=event.target.checked;
            const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
            console.log('@@@@ '+index);
            this.comboxofAddFilter[index].value = event.target.checked;
            this.comboxofAddFilter[index].index =  index;
            this.comboxofAddFilter[index].label =  '';

        }
        else{
            this.fieldValues=event.detail.value;
            const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
            console.log('@@@@ '+index);
            this.comboxofAddFilter[index].value = event.detail.value;
            this.comboxofAddFilter[index].index =  index;
            this.comboxofAddFilter[index].label =  '';
            console.log('Field ',JSON.stringify(this.comboxofAddFilter));
            console.log(' this.amountDataType ', this.amountDataType);

        }
        
        
    }

    handlChangeOnPickListValues(event)
    {
        //this.isGetRecord=false;
        if(this.comboxofAddFilter.length===1)
        {
            this.isGetRecord=false;
        }
        if(this.comboxofAddFilter.length>=2)
        {
            if(this.isConditionRequired===true)
            {
                this.isGetRecord=false;
            }
            else
            {
                this.isLastValue=true;
            }
        }
        this.pickListresult=event.detail.value;
        const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        console.log('@@@@ '+index);
        this.comboxofAddFilter[index].value =  this.pickListresult;
        this.comboxofAddFilter[index].index =  index;
        
    }


    // On click Event get All Record According user Input
    handleOnClickGetRecord()
    {
        this.getReport();        
    }

     // on Selected Limit
     handleOnChangeLimit(event)
     {
         this.limit=event.detail.value;        
        
     }
     handleChangeOnConditions(event)
     {
        //const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        this.condition=event.detail.value;
        //this.isVisibleCustomInput=event.detail.value;
        
        if(this.condition==='true')
        {
            
            this.isCondition=false;
            this.isVisibleCustomInput=true;
        }
        if(this.isLastValue===true)
        {
            this.isGetRecord=false;
        }
        else
        {
            this.isConditionRequired=true;
        }
        
        //this.isGetRecord=false;
        //this.comboxofAddFilter[index].conidtion = this.conidtion;

     }
     handleChangeOnCustomCondi(event)
     {
        var t=event.detail.value;
        var str = t;
        //var result = str.match(/[a-zA-Z]+|\d+/g);
        var result = str.match(/[\(\)]|[a-zA-Z]+|\d+/g);
        this.customConditionUserInput=result;
        if(this.isVisibleCustomInput)
        {
            this.isCondition=false;
        }
        if(this.isLastValue===true)
        {
            this.isGetRecord=false;
        }
    }
    

    
 
}


/*
console.log(this.fieldValues);
        console.log(this.selectedFieldDataType);

        const index = Array.from(this.template.querySelectorAll('.slds-grid')).indexOf(event.target.closest('.slds-grid'));
        console.log('@@@@ '+index);
        this.comboxofAddFilter[index].limit =  this.limit;

        if(this.fieldValues === undefined && this.fieldSelectValue !== undefined && this.pickistDataTypes ===undefined )
        {
            
            this.finalQuary='SELECT '+this.fieldSelectValue+' FROM '+this.objectApi+  
            ' LIMIT '+this.limit;
        }

        else if( this.selectedFieldDataType !==undefined && this.pickistDataTypes !==undefined )
        {
            
            this.finalQuary='SELECT '+this.fieldSelectValue+' FROM '+this.objectApi+' WHERE '+  
            this.selectedFieldDataType + ' ' +this.whereconditions+' ' + '\'' +this.pickListresult +'\''+ 
            ' LIMIT '+this.limit;
        }
        else if( this.selectedFieldDataType !==undefined && this.pickistDataTypes ===undefined && this.amountDataType ==='CURRENCY' )
        {
            
            this.finalQuary='SELECT '+this.fieldSelectValue+' FROM '+this.objectApi+' WHERE '+  
            this.selectedFieldDataType + ' ' +this.whereconditions+' ' +this.fieldValues +
            ' LIMIT '+this.limit;
        }
        else if( this.selectedFieldDataType !==undefined && this.pickistDataTypes ===undefined && this.booleanDataType ==='BOOLEAN' )
        {
            
            this.finalQuary='SELECT '+this.fieldSelectValue+' FROM '+this.objectApi+' WHERE '+  
            this.selectedFieldDataType + ' ' +this.whereconditions+' ' +this.fieldValues +
            ' LIMIT '+this.limit;
        }
        else
        {
            
            this.finalQuary='SELECT '+this.fieldSelectValue+' FROM '+this.objectApi+' WHERE '+  
            this.selectedFieldDataType + ' ' +this.whereconditions+' ' + '\'' + this.fieldValues +'\''+ 
            ' LIMIT '+this.limit;
        }
*/