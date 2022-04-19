public with sharing class GoodInStockTriggerHandler {
    public GoodInStockHandler() {

    }
    public static void updateConsigmentNoteDate (List<Goods_in_stock__c> newList, Map<Id, Goods_in_stock__c> oldMap ){
        Set<Id> listIds = oldMap.keySet();

        List<Consignment_note__c> consignmentNoteList = [SELECT id FROM Consignment_note__c WHERE Goods_in_stock__c IN : listIds];
        
        for (Consignment_note__c cn_i: consignmentNoteList){
            DateTime dT = system.now();
            cn_i.Date__c = date.newinstance(dT.year(), dT.month(), dT.day());
        }
        update consignmentNoteList;
    }
}