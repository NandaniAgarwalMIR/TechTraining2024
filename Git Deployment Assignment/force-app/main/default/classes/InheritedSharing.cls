public class InheritedSharing {
	public static void performDML() {
        Account a = [Select Id from Account where Name = 'Rohit Sharma' LIMIT 1];
        Contact contactObject=new Contact(FirstName='Ritika',LastName='Sharma',AccountId=a.Id);
        insert contactObject;
    }
}