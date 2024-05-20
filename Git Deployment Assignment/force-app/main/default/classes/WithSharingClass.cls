public with sharing class WithSharingClass {
    @AuraEnabled
	public static Integer countAccounts() {
        return [Select Id, Name, Active__c from Account].size();
    }
    
    public static void performDML(Account a) {
        update a;
    }
    
    @AuraEnabled
    public static void performDML() {
        //CRUD, FLS are not enforced 
        //Sharing rules are enforced
        Account a = [Select Id from Account where Name = 'Rohit Sharma' LIMIT 1];
        Contact contactObject=new Contact(FirstName='Ritika',LastName='Sharma',AccountId=a.Id);
        insert contactObject;
        update a;
    }
    
    @AuraEnabled
    public static void performDMLWithoutSharing() {
        //CRUD, FLS are not enforced 
        //Sharing rules are enforced
        Account a = [Select Id from Account where Name = 'Rohit Sharma' LIMIT 1];
        Contact contactObject=new Contact(FirstName='Ritika',LastName='Sharma',AccountId=a.Id);
        insert contactObject;
     
    }
    
    @AuraEnabled
    public static void performDMLInheritedSharing() {
        //CRUD, FLS are not enforced 
        //Sharing rules are enforced
        InheritedSharing.performDML();
    }
    
	@AuraEnabled
    public static String CRUD() {
        //Adding checks for CRUD
        if (Schema.SObjectType.Account.isAccessible()) {
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
        //Sharing rules are enforced
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
                                         AccessType.READABLE, [Select id from Account]);
        System.debug(securityDecision.getRecords());
    }
    
    @AuraEnabled
    public static void stripInaccessibleDML() {
        //CRUD, FLS is enforced
        //Sharing rules are enforced
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
         //Sharing rules are enforced
         System.debug([Select Id, Name, Active__c from Account WITH SECURITY_ENFORCED].size());
    }
    
    @AuraEnabled
    public static void withSecuirtyEnforcedAndWhereClause() {
         //CRUD, FLS is enforced
         //Sharing rules are enforced
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