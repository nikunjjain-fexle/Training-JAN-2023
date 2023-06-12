/*
 * Purpose       : Write Queueable Class Test Of Update Account Field 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 15-04-2023
 * 
 * Revision Log  : V_1.0
 * 
 */ 

@isTest(seeAllData=false)
public class Queueable_UpdateAccountField_Test {

    @testsetup static void setup()
    {
        List<Account>accList=new List<Account>();
        accList.add(new Account(Name='ParentId'));
        
        for(Integer i=1; i<=50; i++)
        {
            Account acc=new Account (Name='Test Account'+i);
            accList.add(acc);
        }
        insert accList;
    }
    
    @isTest(seeAllData=false)
    public static void testQueueable_UpdateAccountField_Test()
    {
        Id ParentId=[Select Id FROM Account WHERE Name='ParentId'][0].id;
        List<Account>accList=[SELECT ID , Name FROM Account WHERE Name LIKE 'Test Account'];
        
        Test.startTest();
        Queueable_UpdateAccountField obj=new Queueable_UpdateAccountField(accList,ParentId);
        Test.stopTest();
        
        //System.assertEquals(50, [SELECT Count() FROM Account ParentId = :ParentId]);
    }
}