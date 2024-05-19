trigger AccountToPersonal on Account(after insert) {
    List<Account> accountList=trigger.new;
    List<Personal_Details__c> insertList=new List<Personal_Details__c>();
    if(trigger.isAfter && trigger.isInsert)
    {
        if(!trigger.new.isEmpty())
        {
            for(Account acc: accountList){
                Personal_Details__c personalDetail =new Personal_Details__c();
                personalDetail.Name=acc.Name;
                personalDetail.Person_Phone__c=acc.Phone;
                personalDetail.Description__c=acc.Description;
                personalDetail.Person_Employee_ID__c=acc.Id;
                personalDetail.Parent_Account__c=acc.Id;
                personalDetail.Person_Email__c=acc.Email__c;
                insertList.add(personalDetail);
            }  
        } 
    }
    insert insertList;
}