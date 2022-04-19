trigger GoodInStockTrigger on Goods_in_stock__c (before insert, before update) {
if (Trigger.isBefore && Trigger.isUpdate) {
    GoodInStockTriggerHandler.updateConsigmentNoteDate(Trigger.New, Trigger.Old);
}
}