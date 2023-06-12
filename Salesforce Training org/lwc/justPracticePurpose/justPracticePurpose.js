import { LightningElement, track } from 'lwc';

//Importing Utilities
import Utilities, {NotificationsUtilities, CustomEventsUtilities} from 'c/utilities';

export default class JustPracticePurpose extends LightningElement 
{
    @track greeting = 'Hello World';

  changeHandler(event) {
    this.greeting = event.target.value;
    
  }

  onAlert(event)
  {
    NotificationsUtilities.showAlertMessageNotification('Error','Error','');
  }
  OnTaost(event){
    NotificationsUtilities.showToastMessageNotification('Record is Successfully','  ','Success ');
  }
  onPrompt(event)
  {
    NotificationsUtilities.showPromptMessageNotification();
    
  }
  onConfirm(event)
  {
    NotificationsUtilities.showConfirmMessageNotification();
  }



}