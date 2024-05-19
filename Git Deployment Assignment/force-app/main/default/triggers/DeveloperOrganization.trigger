trigger DeveloperOrganization on developers__c (before insert)
{
    List<developers__c> devList=trigger.new;
    if(trigger.isBefore && trigger.isInsert)
    {
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get('developers__c').getDescribe();
       	Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
        for (String fieldName : fieldMap.keySet()){
            if(fieldName=='Organization__c')
            {
                for(developers__c devObject:devList){
                devObject.Organization__c='Mirketa';
                
                }

            }
        }
        
    }
   
    

}