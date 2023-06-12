/**
*
*  Purpose          :   Create Visual Page for show object details.
*
*  Created Date     :   
*
*  Created By       :   Nikunj jain
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public class myDynamicClass {
    
    public String name      { get; set; }
    public String fullName  { get; set; }
    public Schema.sobjectType  obj;
    public myDynamicClass()
    {
         obj = Utilities.getObjectTypeOnBasisOfObjectName(name);
    }
    
    public void processName() {
        
        System.debug('Name entered by the user: ' + obj);
    }

}