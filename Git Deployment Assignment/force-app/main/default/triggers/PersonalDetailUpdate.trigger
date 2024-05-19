trigger PersonalDetailUpdate on Personal_Details__c (before update) {
	List<Personal_Details__c> pdlist=trigger.new;
    if(trigger.isBefore && trigger.isUpdate)
    {
        if(!trigger.new.isEmpty())
        {
            for(Personal_Details__c pdobj1:pdlist)
            {
                if(pdobj1.Person_Phone__c!=trigger.oldMap.get(pdobj1.Id).Person_Phone__c)
                {
                    String oldPhone = trigger.oldMap.get(pdobj1.Id).Person_Phone__c;
                    String newPhone=  pdobj1.Person_Phone__c;
                    pdobj1.Description__c='phone number is updated from '+ oldPhone + ' to '+ newPhone;
                  
                }
                if(pdobj1.Person_Email__c!=trigger.oldMap.get(pdobj1.Id).Person_Email__c)
                {
                   String oldEmail = trigger.oldMap.get(pdobj1.Id).Person_Email__c;
                    String newEmail=pdobj1.Person_Email__c;
                    pdobj1.Description__c='Email is updated from '+ oldEmail + ' to '+ newEmail; 
                }
                
            }
        }
    }
    
}