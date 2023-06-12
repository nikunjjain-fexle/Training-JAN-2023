/**
 * Purpose     : Practice
 * 
 * Created By  :
 * 
 * Create Date :
 * 
 * Resion Log  :
 *
*/

 
/*

public static void countTotalStudentsOnUpdate(List<Student__c> students , Map<Id, Student__c> mapOfOldStudents)
    {
        Set<String> schoolNamesToBeUpdated = new Set<String>();

        for(Student__c stu : students)
        {
            if(!((stu.class__c==NULL) && ((mapOfOldStudents.get(stu.Id).class__c)==NULL)))
            {
                if(stu.class__c == NULL)
                {
                    List<Class__c> classOld = [SELECT Name, School__c From class__c WHERE Id = :mapOfOldStudents.get(stu.Id).Class__c];

                    List<School__c> schold = [SELECT Name FROM School__c WHERE ID = :classOld[0].School__c];

                    schoolNamesToBeUpdated.add(schold[0].Name);    
                }
                else if((mapOfOldStudents.get(stu.Id).class__c)==NULL)
                {
                    List<Class__c> classnew = [SELECT Name, School__c From class__c WHERE Id = :stu.class__c];
                    List<School__c> schNew = [SELECT Name FROM School__c WHERE ID = :ClassNew[0].School__c];
                    schoolNamesToBeUpdated.add(schNew[0].Name);    
                }
                else
                {
                    List<Class__c> classnew = [SELECT Name, School__c From class__c WHERE Id = :stu.class__c];
                    List<Class__c> classOld = [SELECT Name, School__c From class__c WHERE Id = :mapOfOldStudents.get(stu.Id).Class__c];
                    List<School__c> schNew = [SELECT Name FROM School__c WHERE ID = :ClassNew[0].School__c];
                    List<School__c> schold = [SELECT Name FROM School__c WHERE ID = :classOld[0].School__c];

                    if(ClassNew[0] != classOld[0] && schNew[0] != schold[0])
                    {
                        schoolNamesToBeUpdated.add(schNew[0].Name);
                        schoolNamesToBeUpdated.add(schold[0].Name);
                    }
                }
            }
        }
        System.debug(schoolNamesToBeUpdated);
        for(String sc : schoolNamesToBeUpdated )
        {
            CountsManager.updateNoOfStudentsDetails(sc);
        }
    }


*/
public Without Sharing class AssesmentPractice {
    
    // Dynamic Apex 
    public static void createContact()
    {
        Map<String,Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        
        for(String ss1 : schemaMap.KeySet())
        {
            if( ss1.equalsignorecase('Contact'))
            {
                Schema.SObjectType objToken=schemaMap.get(ss1);
                
                
                Schema.DescribeSObjectResult objDescribe=objToken.getdescribe();
                system.debug('*********sobjectAPINamel:'+objDescribe.getName());
                system.debug('*********sobjectlabel:'+objDescribe.getlabel());
                system.debug('*********sobjectPrefix:'+objDescribe.getKeyPrefix());
                system.debug('*********IsCustom sobject:'+objDescribe.IsCustom());
                
                
                
                Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
                
                
                for(String ss:Fieldmap.keyset()){
                    
                    Schema.DescribeFieldResult fd=fieldMap.get(ss).getDescribe();
                    
                    system.debug('*********fieldAPINamel:'+fd.getName());
                    system.debug('*********fieldlabel:'+fd.getlabel());
                    system.debug('*********fieldtype:'+fd.gettype());
                    system.debug('*********isNillable:'+fd.isNillable());
                    
                    //check if data type is picklist then find out picklist options
                    
                    if(String.valueof(fd.getType()).equalsignorecase('Picklist'))
                    {
                        
                        List<Schema.PicklistEntry> Pp = fd.getPicklistValues();
                        
                        for(Schema.PicklistEntry p:Pp)
                        {
                            system.debug('****picklist option label'+P.getLabel());
                            system.debug('****picklist option value'+P.getvalue());
                        }
                    }
                }
            }	
            
        }
    }
    
    public static void methodOfDynamic(String objectApiName)
    {
        Type ObjectType =Type.forName('Schema.', objectApiName);
        
        
        
    }
    
    public static void insertionOfContact(List<Contact>listOfContact, Map<id,Contact> oldMapList)
    {
        if(listOfContact != null )
        {
            Set<id>accIds = new Set<id>();
            
            for(Contact con : listOfContact != null ? listOfContact: oldMapList.Values() )
            {
                if(oldMapList != null && con.Contact_Type__c != null)
                {
                    if(con.AccountId != null )
                    {
                        accIds.add(con.AccountId);
                    }
                }
                else
                {
                    accIds.add(con.AccountId);
                }
                
            }
            if(accIds != null && accIds.size() > 0)
            {
                List<Contact> conList =[ SELECT AccountId, Contact_type__C FROM Contact WHERE Contact_type__C = 'Active' AND AccountId =: accIds];
                for(Contact con : listOfContact)
                {
                    
                    if(conList.Size()>=2 && con.Contact_type__C =='Active')
                    {
                        
                        con.addError('Stop here Max 2 Contact Active per Account');
                    }
                    con.Contact_created__c=true;
                     
                }
            }
        }
    }
    
    
    
    
    
    //21. 
    public static void insertionOfContactOnAccountField(List<Account> listOfAccounts)
    {
        if(listOfAccounts != null)
        {
            List<Contact> listOfContactToBeAdded=new List<Contact>();
            
            Set<Id> setofAccountIds=new Set<Id>();
            
            for(Account acc :listOfAccounts)
            {
                setOfAccountIds.add(acc.Id);
            }
            /*
            List<Account> lstAccount;
            if(setOfAccountIds.size()>0)
            {
                lstAccount=[SELECT Id,  Contact_Information__c from Account WHERE Id IN : setOfAccountIds];
            }
            for(Account acc : lstAccount)
            {
                List<String> listOfContactNames=new List<String>();
                if(acc.Contact_Information__c != Null)
                {
                    listOfContactNames=acc.Contact_Information__c.trim().split(',');
                    listOfContactNames=acc.Contact_Information__c.trim().split(',');
                    System.debug(listOfContactNames);
                    Contact con=new Contact();
                    con.LastName=(listOfContactNames[0].split(':'))[1].trim();
                    System.debug(con.LastName);
                    con.Email=(listOfContactNames[1].split(':'))[1].trim();
                    con.Phone=(listOfContactNames[2].split(':'))[1].trim();
                    con.Description=(listOfContactNames[3].split(':'))[1].trim();
                    con.AccountId=acc.Id;
                    listOfContactToBeAdded.add(con);
                    
                }
            }*/
            if(listOfContactToBeAdded.size()>0)
            {
                System.debug('@@@@');
                insert listOfContactToBeAdded;
            }
            
        }
        
    }
    
    
    // 20 Write Trigger on Apex Sharing odf School object on Teacher User 
    public static void doApexSharingOnTeacher(List<School__c> listOfSchoolDetails , Map<Id,School__c>oldMapOfSchoolDetails)
    {
        if(listOfSchoolDetails != null && oldMapOfSchoolDetails != null)
        {
            Set<Id> setOfIdsEligibleUser = new Set<Id>();
            Set<Id> setOfIdsNotEligibleUser = new Set<Id>();
            for(School__c sch : listOfSchoolDetails)
            {
                if(sch.No_Of_Teachers__c > Integer.valueOf(System.label.NO_OF_TEACHERS_THRESHOLD_FOR_SHARING_RECALCULATION))
                {
                    if(sch.No_Of_Teachers__c != null &&  sch.No_Of_Teachers__c != oldMapOfSchoolDetails.get(sch.id).No_Of_Teachers__c )
                    {
                        setOfIdsEligibleUser.add(Sch.id);
                    }
                    else
                    {
                        setOfIdsNotEligibleUser.add(sch.id);
                    }
                }
                else
                {
                    setOfIdsNotEligibleUser.add(sch.id);
                }
                
            }
            if(setOfIdsEligibleUser.size() > 0 && setOfIdsEligibleUser != null)
            {
                List<User> integrationUser = [SELECT Id, isActive FROM User WHERE Id =: System.Label.TEARCHER_USER_RECORD_ID AND isActive= true ];
                if(integrationUser.size() > 0 && integrationUser != null)
                {
                    List<School__Share> updateShareRecord = new List<School__Share>();
                    
                    
                    for(ID sch : setOfIdsEligibleUser)
                    {
                        School__Share schoolRecordShare = new School__Share();
                        schoolRecordShare.UserOrGroupId=integrationUser[0].id;
                        schoolRecordShare.AccessLevel='Read';
                        schoolRecordShare.ParentId=sch;
                        schoolRecordShare.RowCause=Schema.school__share.RowCause.Apex_Sharing__c;
                        updateShareRecord.add(schoolRecordShare);
                    }
                    
                    if(!updateShareRecord.isEmpty())
                    {
                        Utilities.BypassAllTriggers=true;
                        insert updateShareRecord;
                        Utilities.BypassAllTriggers=false;
                    }
                    AssessmentHerokuApp.heroKuAppintegration();
                }
                
            }
            if(setOfIdsNotEligibleUser.size()>0)
                {
                    List<School__Share> listOfManagedSharingRecordsToBeDeleted = [SELECT Id, ParentId, RowCause, UserOrGroupId 
                                                                                  FROM School__share 
                                                                                  WHERE ParentId IN: setOfIdsNotEligibleUser 
                                                                                  AND RowCause =: Constants.SHARING_REASON_APEX_SHARING];
                    if(listOfManagedSharingRecordsToBeDeleted.size() >0)
                    {
                        Utilities.BypassAllTriggers=true;
                        delete listOfManagedSharingRecordsToBeDeleted;
                        Utilities.BypassAllTriggers=false;
                    }
            }
        }
    }
    
    
    // 19. On Account Owner Change Send Email to Old Owner
    
    // 18 . Write a Trigger on Reparent Of Contact And Populate Account Email on Contact Email
    public static void reparentContactpopulateEmailOnContactFromAccount(List<contact> listOfConDetails, Map<id, Contact> oldMapOfConDetails)
    {
            try
            {
                if(listOfConDetails != null && oldMapOfConDetails != null)
                {
                    
                    Map<Id,Contact> mapOfContact =new  Map<Id,Contact>();
                    for(Contact con : listOfConDetails)
                    {
                        if(con.AccountId != null && con.AccountId != oldMapOfConDetails.get(con.id).AccountId )
                        {
                            
                            mapOfContact.put(con.AccountId, con);
                        }
                    }
                    if(mapOfContact != null && mapOfContact.Values().size() > 0)
                    {
                        Map<Id,Account> mapofAccDetails =new  Map<Id,Account>([SELECT Id, Email__c From Account WHERE Id =:mapOfContact.KeySet()]);
                        for(Contact con : listOfConDetails)
                        {
                            con.Email=mapofAccDetails.get(con.AccountId).Email__c;
                        }
                        
                    }
                }
            }
            catch(Exception e)
            {
                
            }
    }
    
    // 17. Write a Trigger on Reparent Of Contact And Populate Contact Email on Account Email
    public static void reparentContact(List<contact> listOfConDetails, Map<id, Contact> oldMapOfConDetails)
    {
        if(listOfConDetails != null && oldMapOfConDetails != null)
        {
            
            Map<Id,Contact> mapOfContact =new  Map<Id,Contact>();
            for(Contact con : listOfConDetails)
            {
                if(con.AccountId != null && con.AccountId != oldMapOfConDetails.get(con.id).AccountId )
                {
                    
                    mapOfContact.put(con.AccountId, con);
                }
            }
            if(mapOfContact != null && mapOfContact.Values().size() > 0)
            {
                List<Account> accList = new List<Account>();
                for(Account acc : [SELECT id, Email__c FROM Account WHERE Id =:mapOfContact.KeySet()])
                {
                    acc.Email__c=mapOfContact.get(acc.id).Email;
                    accList.add(acc);
                }
                if(!accList.isEmpty())
                {
                    Utilities.BypassAllTriggers=true;
                    update accList;
                    Utilities.BypassAllTriggers=false;
                }
                
            }
        }
    }
    
    // 16. write a Trigger on Duplicate Contact if any other Existing Contact Has Same Website
    public static void showDuplicateContact(List<Contact>listOfContactdetails)
    {
        try
        {
            List<String> conListWebsiteDetails= new List<String>();
            
            for(Contact con : [SELECT Website__c FROM Contact])
            {
                conListWebsiteDetails.add(con.Website__c);
            }
            for(Contact con :listOfContactdetails )
            {
                if(conListWebsiteDetails.contains(con.Website__c))
                {
                    con.IsDuplicate__c=true;
                }
                else
                {
                    con.IsDuplicate__c=false;
                }
            }
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
        
       
    }
    // 15. Write a Trigger to populate Total Salary on Account for Contact insert / Update and Delete
    public static void populateTotalSalaryOnAccount(List<Contact>listOfContactdetails, Map<id,Contact>mapOfContact)
    {
        try
        {
           
            if(listOfContactdetails != null || mapOfContact != null)
            {
                Set<id>accIds = new Set<id>();
                
                for(Contact con : listOfContactdetails!= null ? listOfContactdetails : mapOfContact.Values())
                {
                    if(listOfContactdetails != null && mapOfContact != null)
                    {
                        
                        
                        if(con.salary__c != null && con.salary__c != mapOfContact.get(con.id).salary__c)
                        {
                            accIds.add(con.AccountId);
                            
                        }
                    }
                    
                    else
                    {
                        accIds.add(con.AccountId);
                    }
                    
                }
                if(accIds != null && accIds.size() > 0)
                {
                  
                    Decimal Total=0;
                    Map<id,Decimal> mapOfAccountIdWithhTotalSum= new  Map<id,Decimal>();
                    for(Contact con : [SELECT Id, AccountId, Salary__c FROM Contact WHERE AccountId =: accIds])
                    {
                        if(mapOfAccountIdWithhTotalSum.ContainsKey(con.AccountId))
                        {
                            Total=mapOfAccountIdWithhTotalSum.get(con.AccountId);
                        }
                        
                        if(con.Salary__c != null)
                        {
                            Total=con.salary__c+Total;
                            mapOfAccountIdWithhTotalSum.put(con.AccountId, Total);
                            Total=0;
                        }
                    }
                    
                    List<Account> updateAccList = new List<Account>();
                    
                    for(Account acc : [SELECT ID, Total_Salary__c FROM Account WHERE Id =: mapOfAccountIdWithhTotalSum.KeySet()])
                    {
                        acc.Total_Salary__c=mapOfAccountIdWithhTotalSum.get(acc.id);
                        updateAccList.add(acc);
                    }
                    
                    if(!updateAccList.isEmpty())
                    {
                        Utilities.BypassAllTriggers=true;
                        update updateAccList;
                        Utilities.BypassAllTriggers=false;
                    }
                }
            }
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
    // 14.Auto Populat eWebSite And Address Details Of Acccount Object From Contact object
    public static void AutoPopulateWebSiteAndAddressDetailsOnAcccountFromContact(List<Account>accList,Map<id,Account>mapOfOldAccDetails)
    {
        try
        {
           
            if(accList != null || mapOfOldAccDetails != null)
            {
                Set<id>accIds = new Set<id>();
                
                for(Account acc : accList )
                {
                    if(mapOfOldAccDetails != null && accList != null )
                    {
                        if(acc.Email__c != null && acc.Email__c != mapOfOldAccDetails.get(acc.id).Email__c)
                        {
                            accIds.add(acc.Id);
                        }
                        
                    }
                    else
                    {
                        accIds.add(acc.Id);
                    }
                    
                }
                if(accIds != null && accIds.size() > 0)
                {
                    Map<Id,Account> mapOfAccdetails= new Map<Id,Account>([SELECT ID, Website,Email__c,BillingCity,BillingCountry,BillingState,BillingPostalCode FROM Account WHERE Id =:accIds]);
                    
                    List<Contact>updateConList = new List<Contact>();
                    
                    for(Contact con : [SELECT ID,AccountId,Email,Website__c,MailingCity,MailingCountry,MailingState,MailingPostalCode FROM Contact WHERE AccountId =:mapOfAccdetails.KeySet()])
                    {
                        con.Email=mapOfAccdetails.get(con.AccountId).Email__c;
                        con.Website__c = mapOfAccdetails.get(con.AccountId).Website;
                        con.MailingCity =mapOfAccdetails.get(con.AccountId).BillingCity;
                        con.MailingCountry = mapOfAccdetails.get(con.AccountId).BillingCountry;
                        con.MailingState = mapOfAccdetails.get(con.AccountId).BillingState;
                        con.MailingPostalCode = mapOfAccdetails.get(con.AccountId).BillingPostalCode;
                        updateConList.add(con);
                    }
                    if(!updateConList.isEmpty())
                    {
                        
                        Utilities.BypassAllTriggers=true;
                        update updateConList;
                        Utilities.BypassAllTriggers=false;
                    }
                    
                }
            }
            
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
    
     // 13. Auto-Populate Email WebSite And Address Details on Contact From Account
    public static void AutoPopulateWebSiteAndAddressDetailsOnContactFroomAccount(List<Contact>conList)
    {
        try
        {
            if(conList != null)
            {
                Set<id>accIds = new Set<id>();
                for(Contact con : conList )
                {
                    accIds.add(con.AccountId);
                }
                if(accIds != null && accIds.size() > 0)
                {
                    Map<Id,Account> mapOfAccdetails= new Map<Id,Account>([SELECT ID, Website,Email__c,BillingCity,BillingCountry,BillingState,BillingPostalCode FROM Account WHERE Id =:accIds]);
                    for(Contact con : conList)
                    {
                        con.Email=mapOfAccdetails.get(con.AccountId).Email__c;
                        con.Website__c = mapOfAccdetails.get(con.AccountId).Website;
                        con.MailingCity =mapOfAccdetails.get(con.AccountId).BillingCity;
                        con.MailingCountry = mapOfAccdetails.get(con.AccountId).BillingCountry;
                        con.MailingState = mapOfAccdetails.get(con.AccountId).BillingState;
                        con.MailingPostalCode = mapOfAccdetails.get(con.AccountId).BillingPostalCode;
                    }
                    
                    
                }
            }
            
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
    
    // 12. sequencing Of Amount On Opportunity
    public static void sequencingOfAmountOnOpportunity(List<Opportunity>listOfOpp,Map<id,Opportunity>mapOfOpp)
    {
        if(!Utilities.BypassAllTriggers)
        {
            try
            {
                
                if(listOfOpp != null || mapOfOpp != null)
                {
                    Set<id>accIds = new Set<Id>();
                    
                    for(Opportunity opp : listOfOpp != null ? listOfOpp : mapOfOpp.Values())
                    {
                        if(opp.Amount != null && opp.Amount != mapOfOpp.get(opp.id).Amount)
                        {
                            accIds.add(opp.AccountId);
                        }
                        else
                        {
                            accIds.add(opp.AccountId);
                        }
                        
                    }
                    if(accIds.size() > 0 && accIds != null)
                    {
                        Integer i=1;
                        List<Opportunity>oppList = new List<Opportunity>();
                        for(Opportunity opp : [SELECT ID, Amount, AccountId FROM Opportunity WHERE AccountId =: accIds ORDER BY Amount ASC])
                        {
                            opp.Sequence_Number__c=i;
                            i++;
                            oppList.add(opp);
                        }
                        if(!oppList.isEmpty())
                        {
                            Utilities.BypassAllTriggers=true;
                            update oppList;
                            // Utilities.BypassAllTriggers=false;
                        }
                    }
                    
                }
            }
            catch(Exception e)
            {
                System.debug(e.getMessage());
            }
        }
        
    }
    
    
    
    // 11. Auto populate Total Amount Of opp on Account
    public static void autoPopulateTotalAmountOFOppRelateledToAccount(List<Opportunity>listOfOpp,Map<id,Opportunity>mapOfOpp)
    {
     
        if(listOfOpp != null || mapOfOpp != null)
        {
            Set<Id>accIds=new Set<Id>();
            
            for(Opportunity opp : listOfOpp != null ? listOfOpp : mapOfOpp.Values())
            {
                accIds.add(opp.AccountId);
            }
            if(accIds!= null && accIds.size()>0)
            {
                Decimal totalAmount=0;
                for(Opportunity opp: [SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId =:accIds])
                {
                    totalAmount = totalAmount + opp.Amount;
                }
                List<Account> acclist=new List<Account>();
                for(Account acc : [SELECT Id,Total_Amount__c FROM Account WHERE ID =:accIds])
                {
                    acc.Total_Amount__c=totalAmount;
                    acclist.add(acc);
                }
                if(!acclist.isEmpty())
                {
                    Utilities.BypassAllTriggers=true;
                    update acclist;
                    Utilities.BypassAllTriggers=false;
                }
            }
        }
    }
    
    //10. Show Error if try delete Account when Realted Contact have.
    public static void showErrorOnAccount(List<Account>listOfAccount)
    {
        if(listOfAccount != null )
        {
            List<Contact>conList=[SELECT Id ,AccountId FROM Contact WHERE AccountId =:listOfAccount[0].Id];
            
            for(Account acc : listOfAccount)
            {
                if(conList.size() != null && conList != null)
                {
                    
                    acc.AddError('Sorry You Can Not Delete');
                }
            }
            
        }
    }
    // 9. updation of Account update All related Contact 
    public static void updateRelatedContactPhoneFiled(List<Account>listOfAccount,Map<Id,Account>mapOfAccount)
    {
        if(listOfAccount != null || mapOfAccount != null )
        {
            Set<Id> setAccIds=new Set<Id>();
            String phone_Number='';
            for(Account acc : listOfAccount)
            {
               if(acc.Phone != null && acc.Phone != mapOfAccount.get(acc.id).Phone)
               {
                   setAccIds.add(acc.id);
                   phone_Number=acc.Phone;
               }
            }
            if(setAccIds.size() > 0 && setAccIds != null)
            {
                List<Contact>updateConList=new List<Contact>();
                for(Contact con : [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId =:setAccIds])
                {
                    con.Phone=phone_Number;
                    updateConList.add(con);
                }
                Utilities.BypassAllTriggers=true;
                update updateConList;
                Utilities.BypassAllTriggers=false;
            }
        }
    }
    
    // 8. Create custom checkBox id Check Box is True copy billing Address to mailling Address
    public static void copyBillingAddressToMaillingAddress(List<Account>listOfAccount)
    {
        System.debug('kkkkkkk____---');
        if(listOfAccount != null)
        {
            System.debug('listOfAccount--'+listOfAccount);
            
            Set<id>setAccId= new Set<id>();
            for(Account acc : listOfAccount)
            {
                if(acc.Copy_Address__c == true && acc.BillingStreet != null)
                {
                    setAccId.add(acc.id);
                }
            }
            if(setAccId != null && setAccId.size() > 0)
            {
                
               System.debug('setAccId--'+setAccId);
                for(Account acc : listOfAccount)
                {
                    acc.ShippingCity=acc.BillingCity;
                    acc.ShippingCountry=acc.BillingCountry;
                    acc.ShippingState=acc.BillingState;
                    acc.ShippingPostalCode=acc.BillingPostalCode;
                    
                }
                
            }
        }
    }
    
    // 7. insertion Of Contact update  Phone number of Account to Contact Phone Number
    public static void insertionOfContactUpdate(List<Contact>listOfContact)
    {
        if(listOfContact != null)
        {
            Set<Id> setAccIds=new Set<Id>();
            String phone_Number='';
            for(Contact con : listOfContact)
            {
                setAccIds.add(con.AccountId);
                phone_Number=con.Phone;
            }
            if(setAccIds.size() > 0 && setAccIds != null)
            {
                List<Account>updateAccList=new List<Account>();
                for(Account acc : [SELECT Id, Phone FROM Account WHERE Id =:setAccIds])
                {
                    acc.Phone=phone_Number;
                    updateAccList.add(acc);
                }
                Utilities.BypassAllTriggers=true;
                update updateAccList;
                Utilities.BypassAllTriggers=false;
            }
        }
    }
    
    // 6. Delete Contact When Account Type Field Update
    public static void deleteContactIfAccountFieldChange(List<Account>listOfAccount, Map<Id,Account>mapOfContact)
    {
        if(listOfAccount!= null)
        {
            Set<id>accIds=new Set<Id>();
            for(Account acc : listOfAccount )
            {
                if(acc.Type != null && acc.Type != mapOfContact.get(acc.id).Type)
                {
                    accIds.add(acc.id);
                }
            }
            if(accIds != null  && accIds.Size()>0)
            {
                List<Contact>conlist=[SELECT Id, AccountId FROM Contact WHERE AccountId =:accIds ];
                Delete conlist;
            }
        }
    }
    
    
    
    
    
    
    
    
    //5 Find Account related Contact
    public static void findRelatedContact()
    {
        List<Account>listOfAccount=[SELECT Id, Name,(SELECT Id,LastName FROM Contacts) FROM Account WHERE Name='A'];
        for(Account acc: listOfAccount)
        {
            for(Contact con :acc.contacts)
            {
                System.debug('------>'+con);
            }
        }
        
    }
    
    
    
    
    // 5.Write Do Apex Calcuations
    public static void doApexCalculations(Id SchoolId)
    {
        
    }
    
    
    
     // 4. Write Apex Programe No Of Classes Easy Way on School Object
    public static void NoOfClassesEasyWayTo(Id SchoolId)
    {
        if(SchoolId != null)
        {
            System.debug('-----------------Setup 1 clear in call method');
            List<School__c> listOfUpdateSchool = new List<School__c>();
            
            for(School__c schl : [SELECT Id, No_Of_Class__c, (SELECT Id FROM Classes__r) FROM School__c WHERE Id =:  SchoolId])
            {
                schl.No_Of_Class__c=schl.classes__r.Size();
                listOfUpdateSchool.add(schl);
                System.debug('-----------------Setup 2 clear in call method');
            }
            if(listOfUpdateSchool.size() >0)
            {
                System.debug('-----------------Setup 3 clear in call method'+listOfUpdateSchool);
                Utilities.BypassAllTriggers=true;
                update listOfUpdateSchool;
                Utilities.BypassAllTriggers=false;
            }
        }
    }
    
    
    
    
    // 3. Write Apex Programe No Of  Classes on School Object
    public static void NoOfClasses(Id SchoolId)
    {
        if(SchoolId != null)
        {
            Map<Id,School__c> mapOfSchoolDetails=new Map<Id,School__c>();
            
            for(School__c schl : [SELECT Id, No_Of_Class__c FROM School__c WHERE Id =:  SchoolId])
            {
                mapOfSchoolDetails.put(schl.id,schl);
            }
            
            if(mapOfSchoolDetails.size() >0 && mapOfSchoolDetails != null)
            {
                 Map<Id,Integer> mapOfClassesDetails=new Map<Id,Integer>();
                 for(Class__c cl : [SELECT Id, School__c FROM Class__c WHERE School__c != null])
                 {
                     if(!mapOfClassesDetails.containsKey(cl.School__c))
                     {
                         mapOfClassesDetails.put(cl.School__c, 1);
                     }
                     else
                     {
                         mapOfClassesDetails.put(cl.School__c, mapOfClassesDetails.get(cl.School__c)+1);
                     }
                      
                 }
                if(mapOfClassesDetails.size() >0 && mapOfClassesDetails != null)
                {
                    List<School__c> listOfUpdateSchool = new List<School__c>();
                    for(School__c schl :mapOfSchoolDetails.values())
                    {
                        if(mapOfClassesDetails.Containskey(schl.id))
                        {
                            schl.No_Of_Class__c=mapOfClassesDetails.get(schl.id);
                            System.debug('-----------------Setup 3 clear in call method----------'+mapOfClassesDetails.get(schl.id));
                        }
                        else
                        {
                            schl.No_Of_Class__c=0;
                        }
                        listOfUpdateSchool.add(schl);
                    }
                    if(listOfUpdateSchool.size() >0)
                    {
                        System.debug('-----------------Setup 3 clear in call method------------>'+listOfUpdateSchool);
                        Utilities.BypassAllTriggers=true;
                        update listOfUpdateSchool;
                        Utilities.BypassAllTriggers=false;
                    }
                }
                
            }
                                     
        }
    }
    
    
    // 3. Write Apex Programe No Of Student O School Object
    public static void NoOfStudent(String SchoolName)
    {
        
        if(String.isNotBlank(SchoolName))
        {
            System.debug('Yes Call it');
            Map<Id,School__c> mapOfSchoolDetails = new Map<Id,School__c>();
            for(School__c schl : [SELECT Id, Name, No_Of_Student__c FROM School__c WHERE Name =:SchoolName.trim()])
            {
                mapOfSchoolDetails.put(schl.id,schl);
            }
            System.debug('mapOfSchoolDetails'+mapOfSchoolDetails);
            if(mapOfSchoolDetails != null && mapOfSchoolDetails.size() > 0)
            {
                Map<Id,Integer> mapOfStudentDetails = new Map<Id,Integer>();
                
                for(Student__c str :[SELECT Id, Class__c, Class__r.School__c FROM Student__c 
                                     WHERE Class__c != null
                                     AND Class__r.School__c != null ])
                {
                    if(!mapOfStudentDetails.containsKey(str.Class__r.School__c))
                    {
                        mapOfStudentDetails.put(str.Class__r.School__c, 1);
                    }
                    else
                    {
                        mapOfStudentDetails.put(str.Class__r.School__c,mapOfStudentDetails.get(str.Class__r.School__c)+1);
                    }
                }
                 System.debug('mapOfStudentDetails'+mapOfStudentDetails);
                if(mapOfStudentDetails.size() > 0 && mapOfStudentDetails != null)
                {
                    List<School__c> listOfupdateSchoolDetails=new List<School__c>();
                    
                    for(School__c mp:mapOfSchoolDetails.values())
                    {
                        if(mapOfStudentDetails.containsKey(mp.id))
                        {
                            mp.No_Of_Student__c=mapOfStudentDetails.get(mp.id);
                        }
                        
                        else
                        {
                            mp.No_Of_Student__c=0;
                        }
                        listOfupdateSchoolDetails.add(mp);
                    }
                    if(listOfupdateSchoolDetails.size() >0)
                    {
                        Utilities.BypassAllTriggers=true;
                        update listOfupdateSchoolDetails;
                        Utilities.BypassAllTriggers=false;
                    }
                    
                }
            }
            else
            {
                System.debug('No  School Here Realted This Name');
            }
        }
        else
        {
            System.debug('Please Enter Valid School Name ');
        }
    }
    
    // 2. Write Apex Program dyanmic Way to Deal With Collection By School --> Class --> Student
    public static void dyanmicWayToDealWithCollection()
    {
        Map<String,Map<String,List<Student__c>>> mapOfSchoolDetails=new  Map<String,Map<String,List<Student__c>>>();
        
        for(Student__c str : [SELECT Id, Name, Class__r.Name, Class__r.School__r.Name FROM Student__c
                              WHERE Class__r.Name != null
                              AND  Class__r.School__r.Name != null ])
        {
            if(mapOfSchoolDetails.containsKey(str.Class__r.school__r.Name))
            {
                if(mapOfSchoolDetails.get(str.Class__r.school__r.Name).containsKey(str.Class__r.Name))
                {
                    mapOfSchoolDetails.get(str.Class__r.school__r.Name).get(str.Class__r.Name).add(str);
                }
                else
                {
                    mapOfSchoolDetails.get(str.Class__r.school__r.Name).put(str.Class__r.Name, new List<Student__c>());
                }
            }
            else
            {
                Map<String, List <Student__c>> mapOfClassesDetails = new Map<String,List<Student__c>>();                
                if(mapOfClassesDetails.get(str.Class__r.Name) == null)
                {
                    mapOfClassesDetails.put(str.Class__r.Name,new List<Student__c>());
                }
                mapOfClassesDetails.get(str.Class__r.Name).add(str);
                mapOfSchoolDetails.put(str.Class__r.school__r.Name,mapOfClassesDetails);
            }
        }
        System.debug('@@@@mapOfSchoolDetails --------->'+mapOfSchoolDetails);
    }
    
    
    // 1. Write Apex Program Static Way to Deal With Collection By Counry--> State --> City
    public static void staticWayToDealWithCollection()
    {
        Map<String,Map<String,List<String>>> mapOfCountryStateCity = new Map<String,Map<String,List<String>>>
        {
            'India'=> new Map<String,List<String>>
            {
                'Rajasthan'=> new List<String>{'Jaipur','Udaipur','Dungarpur'},
                    'Goa'=> new List<String>{'G1','G2','G3'}
            },
            'UK'=> new Map<String,List<String>>
            {
                'Paris'=> new List<String>{'Paris1','Paris2','Paris3'},
                    'P'=> new List<String>{'p1','p2','p3'}
            }
        };
        
            System.debug('@@@@ mapOfCountryStateCity ----> '+mapOfCountryStateCity);
    }

}