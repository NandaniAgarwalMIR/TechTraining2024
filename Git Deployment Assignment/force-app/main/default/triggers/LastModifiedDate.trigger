trigger LastModifiedDate on Opportunity (before insert,before update) {
    if(trigger.isBefore && (trigger.isInsert ||trigger.isUpdate)){
       set<Id> accid = new set<Id>();
        for(Opportunity opp:trigger.new)
        {
             accid.add(opp.AccountId);
        }
        List<Account> accList=[select Id from Account where Id IN: accid];
        for(Account acc:accList)
        {
            acc.Lastmodifieddate__c=date.today();
        }
        update accList;
    }
}