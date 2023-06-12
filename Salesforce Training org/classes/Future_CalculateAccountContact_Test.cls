/*
 * Purpose       : Write Test Class Of Future Calculation of Total Contact on Account
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 15-04-2023
 * 
 * Revision Log  : V_1.0  
 * 
 */ 

@isTest(seeAllData=false)
public class Future_CalculateAccountContact_Test {
    @isTest(seeAllData=false)
    public static void testCalculationOfTotalContact()
    {
        List<Account>acclist=new List<Account>();
        for(Integer i=1; i<5; i++)
        {
            Account acc=new Account(Name='Test'+i);
            acclist.add(acc);
        }
        insert acclist;
        List<Contact>conlist=new List<Contact>();
        List<id>accIds=new List<Id>();
        for(Account acc:accList)
        {
            Contact con=new Contact(LastName='Test', AccountId=acc.id);
            conlist.add(con);
            accIds.add(acc.id);
        }
        insert conlist;

        
        Test.startTest();
  
        Future_CalculateAccountContact.calculateContact(accIds);
        
        Test.stopTest();
        
        List<Account>updatedAccNow=[SELECT id, No_Of_Contact__c FROM Account ];
        System.assertEquals(1, updatedAccNow[0].No_Of_Contact__c);
    }
}