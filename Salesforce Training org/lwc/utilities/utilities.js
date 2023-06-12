/*
*
*  Purpose          :	Constants Component JS
*
*  Created Date     :  	20-06-2023
*
*  Created By       :  	Nikunj jain
*
*  Revision Logs    :  	V_1.0 - Created 
*
*/

import { LightningElement } from 'lwc';

//Import Toast message
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//Import Alert message
import LightningAlert from 'lightning/alert'; 

//Import Confirm message
import LightningConfirm from 'lightning/confirm';

//Import Prompt message
import LightningPrompt from 'lightning/prompt';

import { NavigationMixin } from 'lightning/navigation';

//Importing Constants
import {PAGEREFERENCE_TYPES, STATUS_MESSAGES} from 'c/constants';

const ERROR_MESSAGE_I_AM_KIDDING = 'I am kidding !!';

//Default Export of a class/function/property
export default class Utilities extends NavigationMixin(LightningElement) 
{
    
    static navigateToWebPage(urlPrefix, searchString, component) 
    {
        if(!Object.is(searchString, null) && !Object.is(urlPrefix, null)) 
        {
            component[NavigationMixin.Navigate](
            {
                type: PAGEREFERENCE_TYPES.PAGEREFERENCE_TYPE_NAVIGATE_TO_WEB_PAGE,
                attributes: 
                {
                    url: urlPrefix + searchString
                }
            });
        }
        else
        {
            showToastMessage(STATUS_MESSAGES.ERROR_LOWERCASE , ERROR_MESSAGE_I_AM_KIDDING, STATUS_MESSAGES.ERROR_LOWERCASE);
        }
    }
}

//Class
class EventUtilities {}


class CustomEventsUtilities extends EventUtilities 
{
    //Method
    fireCustomEvent(customEventName, details, component) 
    {
        const selectedEvent = new CustomEvent(customEventName, 
        {
            detail: details
        })
        component.dispatchEvent(selectedEvent);
    }
}

class NotificationsUtilities 
{
    static showToastMessageNotification(strTitle, strMsg, strType)
    {
        const successToast = new ShowToastEvent(
        {
            title : strTitle,
            message : strMsg,
            variant : strType
        });
        dispatchEvent(successToast);
    }

    static showAlertMessageNotification(errorMsg,errorTheme,errorLabel)
    {
        LightningAlert.open(
        {
            message: errorMsg,
            theme: errorTheme, 
            label: errorLabel, 
        });
        
    }

    static showPromptMessageNotification()
    {
        LightningPrompt.open(
        {
            message: 'This is the prompt message.',
            //theme defaults to "default"
            label: 'Please Respond!', // this is the header text
            defaultValue: 'Enter a message',
        })
        .then(() => 
        {
            // prompt modal has been closed
        });
    }

    static showConfirmMessageNotification()
    {
        LightningConfirm.open(
        {
            message: 'I am kidding guys',
            variant: 'headerless',
            label: 'This is the aria-label value',
            // label value isn't visible in the headerless variant
        });
        // confirm modal has been closed
    }
}

export {CustomEventsUtilities, NotificationsUtilities};