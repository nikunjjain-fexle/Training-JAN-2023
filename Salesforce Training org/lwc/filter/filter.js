import { LightningElement, track } from 'lwc';

export default class filter extends LightningElement {
  @track customConditions = [];

  comboOptions1 = [{ label: 'Option 1', value: 'Option 1' }, { label: 'Option 2', value: 'Option 2' }];
  comboOptions2 = [{ label: 'Option A', value: 'Option A' }, { label: 'Option B', value: 'Option B' }];

  addRow() {
    this.customConditions.push({
        field: '',
        operator: '',
        value: ''
    });
}
removeCustomCondition(index) {
  this.customConditions.splice(index, 1);
}


  handleFieldChange(event) {
    const index = event.target.dataset.index;
    this.customConditions[index].field = event.target.value;
}

handleOperatorChange(event) {
    const index = event.target.dataset.index;
    this.customConditions[index].operator = event.target.value;
}

handleValueChange(event) {
    const index = event.target.dataset.index;
    this.customConditions[index].value = event.target.value;
}

handleRemoveCondition(event) {
    const index = event.target.dataset.index;
    this.removeCustomCondition(index);
}


  
}