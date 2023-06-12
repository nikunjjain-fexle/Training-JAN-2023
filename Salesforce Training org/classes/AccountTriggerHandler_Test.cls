/*
 * Purpose     : Write Test Class Delete Realted Record of Account When Account Field Will be Changed.
 * 
 * Created By  : Nikunj Jain
 * 
 * Create Date : 03-04-2023
 * 
 * Resion Log  : V_1.0 created  03-04-2023
 *
*/
 //Story        : There have a Account on object Type Field if Type field is change or updated then related Contact will be deleted.


@isTest(SeeAllData=false)

public Without Sharing class AccountTriggerHandler_Test {
    
    @testSetup static void setup()
    {
        Account acc=new Account();
        acc.Name='Nj';
        acc.Type='Prospect';
        insert acc;
        
        List<contact>conList=new List<Contact>();
        Contact con=new Contact();
        con.AccountId=acc.id;
        con.LastName='con1';
        conList.add(con);
        
        Contact con2=new Contact();
        con2.AccountId=acc.id;
        con2.LastName='con2';
        conList.add(con2);
        
        insert conList;
    }
    
    @isTest(SeeAllData=false)
    public static void testDeleteRealtedRecord()
    {
        List<Account>accList=[SELECT ID,Type FROM Account];
        List<contact>conList=[SELECT ID, Name FROM contact WHERE AccountId =:accList];
        System.assertEquals(2, conList.size());
        System.debug('>>>>>>>>>>'+conList);
        Test.startTest();
        for(Account acc:accList)
        {
            acc.Type='Other';
        }
        update accList;
        
        Test.stopTest();
        List<contact>updatedConList=[SELECT ID, Name FROM contact WHERE AccountId =:accList];
        System.debug('>>>>>>>>>>'+conList);
        System.assertEquals(0, updatedConList.size());
        
    }

}