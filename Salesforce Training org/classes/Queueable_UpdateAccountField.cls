/*
 * Purpose       : Write Queueable Class  Of Update Account Field 
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 15-04-2023
 * 
 * Revision Log  : V_1.0
 * 
 */ 

public class Queueable_UpdateAccountField implements Queueable {
    
    private List<Account>accList;
    private Id parentId;
    public Queueable_UpdateAccountField(List<Account>accList ,Id parentId)
    {
        this.accList=acclist;
        this.parentId=parentId;
    }
    
    public  void execute(QueueableContext Context)
    {
        for(Account acc :accList)
        {
            acc.parentId=parentId;
        }
        if(!accList.isEmpty())
        {
            update accList;
        }
    }

}

/*
 list<Account>accList=[SELECT ID FROM Account WHERE BillingState='NY'];
ID ParentId=[SELECT ID FROM Account WHERE Name='Ritik'][0].id;

Queueable_UpdateAccountField obj=new Queueable_UpdateAccountField(accList,ParentId);

Id jobId=System.enqueueJob(obj);
*/