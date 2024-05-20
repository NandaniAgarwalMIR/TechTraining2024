trigger NewAccountTrigger on New_Account_Entry__e (after insert) {
    System.debug('trigger');
 //   for(New_Account_Entry__e obj:trigger.new){
   //     System.debug(obj.Account_Name__c);
    //}
}