public without sharing class WithoutSharingClass {
    
    @AuraEnabled
    public static Integer countAccounts() {
        //CRUD, FLS and Sharing rules are not enforced
        return [Select Id, Name, Rating from Account].size();
    }
    
    @AuraEnabled
    public static void performDML() {
        //CRUD, FLS and Sharing rules are not enforced 
        Account a = [Select Id from Account where Name = 'MS DHONI' LIMIT 1];
        Contact contactObject=new Contact(FirstName='Ziva',LastName='Dhoni',AccountId=a.Id);
        insert contactObject;
        //Database.insert(contactObject, false, Access_Level.USER_MODE);
    }
    
    public static void performDML(Account a) {
        update a;
    }
    
    @AuraEnabled
    public static void performDMLWithSharing() {
       	//CRUD, FLS and Sharing rules are not enforced 
        Account a = [Select Id from Account where Name = 'MS DHONI' LIMIT 1];
        Contact contactObject=new Contact(FirstName='Ziva',LastName='Dhoni',AccountId=a.Id);
        insert contactObject;
        //CRUD, FLS are not enforced. Sharing rules are enforced
        
    }
    
    @AuraEnabled
    public static void performDMLInheritedSharing() {
        //CRUD, FLS and Sharing rules are not enforced 
        InheritedSharing.performDML();
    }
    
	@AuraEnabled
    public static String CRUD() {
        //Adding checks for CRUD
        if (Schema.SObjectType.Contact.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
    
    @AuraEnabled
    public static String FLS() {
        //Adding Checks for FLS
        if (Schema.SObjectType.Account.fields.Name.isAccessible()) {
            return 'Access Denied';
        } else {
            return 'Access Provided';
        }
    }
    
    @AuraEnabled
    public static void stripInaccessibleSOQL() {
        //CRUD, FLS is enforced
        //Sharing rules are not enforced
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
                                         AccessType.READABLE, [Select id from Account]);
        System.debug(securityDecision.getRecords());
    }
    
    @AuraEnabled
    public static void stripInaccessibleDML() {
        //CRUD, FLS is enforced
        //Sharing rules are not enforced
        List<Account> newAccounts = new List<Account>();
        Account a = new Account(Name='Acme Corporation');
        Account b = new Account(Name='Blaze Comics', Rating='Warm');
        newAccounts.add(a);
        newAccounts.add(b);
        
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE, newAccounts);
        
        // No exceptions are thrown and no rating is set
        insert securityDecision.getRecords();
        
        System.debug(securityDecision.getRemovedFields().get('Account')); // Prints "Rating"
        System.debug(securityDecision.getModifiedIndexes()); // Prints "1"
    }
    
    @AuraEnabled
    public static void securityEnforcedSOQL() {
         //CRUD, FLS is enforced
         //Sharing rules are not enforced
         System.debug([Select Id, Name, Active__c from Account WITH SECURITY_ENFORCED].size());
    }
    
    @AuraEnabled
    public static void withSecuirtyEnforcedAndWhereClause() {
         //CRUD, FLS is enforced
         //Sharing rules are not enforced
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH SECURITY_ENFORCED].size());
    }
    
    @AuraEnabled
    public static void withUserModeAndWhereClause() {
         //CRUD, FLS and Sharing Rule is enforced
         System.debug([Select Id, Name from Account where Rating = 'Warm' WITH USER_MODE].size());
    }
    
    @AuraEnabled
    public static void performDMLWithUserMode() {
         Account a = [Select Id from Account where Name = 'System Admin Created' LIMIT 1];
         //CRUD, FLS and Sharing Rule is enforced
		 update as user a;
    }
}