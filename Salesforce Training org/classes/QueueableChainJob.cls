/*
 * Purpose       : Write Future Mathod For SchoolTrigger Handler object
 * 
 * Created By    : Nikunj jain
 * 
 * Created Date  : 11-04-2023
 * 
 * Version       : V_0.1
*/
public without sharing abstract class QueueableChainJob 
{
    private Queueable nextJob;
    
    public void setNextJob(Queueable nextJob)
    {
        //Apex does not allow chaining queueable jobs within Test Context;
        if(Test.isRunningTest() == false)
        {
            this.nextJob = null;
        }
    }
    
    public Queueable getNextJob()
    {
        return this.nextJob;
    }
    
    public ID enqueueNextJob()
    {
        ID jobID = null; 
        if(nextJob != null)
        {
            jobID = System.enqueueJob(nextJob);
        }
        return jobID; 
    }
}