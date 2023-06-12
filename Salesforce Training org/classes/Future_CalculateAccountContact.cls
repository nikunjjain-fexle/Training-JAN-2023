/*
 * Purpose       : Write Future Method Class on Account object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 15-04-2023
 * 
 * Revision Log  : V_1.0 Created 07/04/2023 
 * 
 */ 


public class Future_CalculateAccountContact {
    @future
    public static void calculateContact(List<Id>Ids)
    {
        List<Account>accList=[SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        for(Account acc: accList)
        {
            acc.No_Of_contact__c=acc.Contacts.size();
        }
        if(!accList.isEmpty())
        {
            update accList;
        }
    }
}

/*
List<Id>listAccIds=new List<Id>{'0012w00001T9D2VAAV'};
Future_CalculateAccountContact.calculateContact(listAccIds);

*/