trigger ProductTrigger on GoodsInStock__c (before insert, before update) {
    if(Trigger.isUpdate && Trigger.isBefore) {
        ProductTriggerHandler.updateConsigmentNoteDate(Trigger.New, Trigger.oldMap);l
    }
}