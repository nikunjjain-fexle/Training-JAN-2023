/**
*
*  Purpose          :   Contact Trigger Handler Test class 
*
*  Created Date     :   19-05-2023
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
@isTest(seeAllData=false)
public class ContactTriggerHandler_Tests {
    
    @testsetup static void setup()
    {
        Account acc= new Account();
        acc.Name='Acc1';
        acc.Email__c='nikunjjain@gmail.com';
        insert acc;
        
        Account acc1= new Account();
        acc1.Email__c='nikunjjain@gmail.com';
        acc1.Name='Acc2';
        insert acc1;
        
        List<Contact> conList=new List<Contact>();
        integer k=1;
        for(integer i=1; i<=8; i++)
        {
            if(K<=3)
            {
                Contact con= new Contact(lastName='con'+i, AccountId=acc.id);
                conlist.add(con);
            }
            else
            {
                Contact con= new Contact(lastName='con'+i, AccountId=acc1.id);
                conlist.add(con);
            }
            k++;
        }
        insert conList;
    }
    @isTest(seeAllData=false)
    public static void testContactToAccount()
    {
        
     
        Test.startTest();
        
        List<Contact>conlist1=new List<Contact>();
        for(Contact con: [SELECT Email FROM Contact])
        {
            con.Email='Hi@gmail.com';
            conlist1.add(con);
        }
        update conlist1;
        
        
        Test.stopTest();
        System.debug([SELECT Email FROM Contact]);
        List<contact> conlist =[SELECT Email FROM Contact WHERE  Email='nikunjjain@gmail.com'];
        System.debug(conlist.size());
        System.assertEquals(8, conlist.size());
    }

}