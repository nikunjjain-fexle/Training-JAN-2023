/*
  Purpose      : Invocable Method Of Create Contact Record
  
  Created By   : Nikunj Jain

  Created Date : 16-05-2023

  Version      : V_0.1

  Story        : 
 
*/
public without sharing class CreateContactRecord 
{
    @InvocableMethod(label='Create Contact Record' description='Creating Record on Insert of Acccount')
    public static List<List<Contact>> insertContactRecord(List<String> inputOfAccountContactInfoFieldDetails)
    {
        List<Contact> conList = new List<contact>();
        if(inputOfAccountContactInfoFieldDetails.size() > 0 && inputOfAccountContactInfoFieldDetails != null )
        {
            List<String> contactInformation = inputOfAccountContactInfoFieldDetails[0].split('\n');
            
            
            String firstName;
            String LastName;
            String Email;
            
            for(String jk : contactInformation)
            {
                List<String> s=jk.split(',');
               
                for(String sp : s)
                {
                    
                    if(sp.substringBefore(':') == 'firstName')
                    {
                        firstName=sp.substringAfter(':');
                        System.debug('firstName='+firstName);
                        
                    }
                    else if(sp.substringBefore(':') == 'LastName')
                    {
                        LastName=sp.substringAfter(':');
                        System.debug('LastName='+LastName);
                    }
                    else if(sp.substringBefore(':') == 'Email')
                    {
                        Email=sp.substringAfter(':');
                        System.debug('Email='+Email);
                    }
                    if(String.isNotBlank(LastName)&&String.isNotBlank(firstName)&&String.isNotBlank(Email))
                    {
                        Contact con=new Contact();
                        con.FirstName=firstname;
                        con.LastName=LastName;
                        con.Email=Email;
                        //con.AccountId=inputAccountDetails[0].id;
                        conList.add(con);
                         firstName='';
                         LastName='';
                         Email='';
                    }
                    
                }
                
                
            }
            
        }
        List<List<contact>> finalListOfContact = new  List<List<contact>>();
        
        finalListOfContact.add(conList);
        System.debug('finalListOfContact----'+finalListOfContact);
        return finalListOfContact;
    }
}