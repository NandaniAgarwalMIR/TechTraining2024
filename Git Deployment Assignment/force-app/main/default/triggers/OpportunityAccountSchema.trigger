trigger OpportunityAccountSchema on Account (after insert) {
    if(trigger.isAfter && trigger.isInsert)
    {
        
        List<Opportunity> oppList=new List<Opportunity>();
            for(Account acc:trigger.new){
                Opportunity oppObj=new Opportunity();
                oppObj.AccountId=acc.ID;
                oppObj.Name=acc.Name;
                oppObj.StageName='Prospecting';
                oppObj.CloseDate=Date.today();
                oppList.add(oppObj);
            }
            Database.insert(oppList,accesslevel.user_mode);
    }
    }