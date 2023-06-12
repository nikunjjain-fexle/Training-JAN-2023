public class CreationOfContactRecord {
    @AuraEnabled(cacheable = false)
    public static Contact contactRecMethod(Contact conRec){
        try {
            
            insert conRec;
            return conRec;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

       
    }

}