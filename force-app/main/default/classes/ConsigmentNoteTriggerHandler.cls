public with sharing class ConsigmentNoteTriggerHandler {
  public ConsigmentNoteTriggerHandler() {
  }
  public static void beforeUpdate( List<Consignment_note__c> newList, Map<Id, Consignment_note__c> oldMap) {
    updateGoodInStockDate(newList, oldMap);
  }

  public static void afterInsert(List<Consignment_note__c> newList) {
    countNumberOfChild(newList, null);
  }

  public static void afterUpdate(List<Consignment_note__c> newList, Map<Id, Consignment_note__c> oldMap) {
    countNumberOfChild(newList, oldMap);
  }

  public static void afterDelete(Map<Id, Consignment_note__c> oldMap) {
    countNumberOfChild(null, oldMap);
  }

  public static void updateGoodInStockDate(List<Consignment_note__c> newList,Map<Id, Consignment_note__c> oldMap) {
    Set<Id> listIds = new Set<Id>();

    for (Consignment_note__c cn_i : newList) {
      if (cn_i.Goods_in_stock__c != null) {
        listIds.add(cn_i.Goods_in_stock__c);
      }
    }
    List<Goods_in_stock__c> goodsInStockList = [SELECT id FROM Goods_in_stock__c WHERE id IN :listIds];

    for (Goods_in_stock__c gs_i : goodsInStockList) {
      DateTime dT = system.now();
      gs_i.Date__c = date.newinstance(dT.year(), dT.month(), dT.day());
    }
    update goodsInStockList;
  }

  private static void countNumberOfChild(List<Consignment_note__c> newList, Map<Id, Consignment_note__c> oldMap) {
    Set<Id> listIds = new Set<Id>();

    if (oldMap != null) {
      for (Consignment_note__c cn_i : oldMap.values()) {
        system.debug('new value ' + cn_i.Goods_in_stock__c);
        system.debug('old value ' + oldMap.get(cn_i.id).Goods_in_stock__c);

        // if(newList == null ||
        // oldMap.get(cn_i.id).Goods_in_stock__c != cn_i.Goods_in_stock__c) {
        if (cn_i.Goods_in_stock__c != null) {
          listIds.add(cn_i.Goods_in_stock__c);
        }
        // }
      }
    }

    if (newList != null) {
      for (Consignment_note__c cn_i : newList) {
        // if(oldMap == null || oldMap.get(cn_i.id).Goods_in_stock__c != cn_i.Goods_in_stock__c){
        if (cn_i.Goods_in_stock__c != null) {
          listIds.add(cn_i.Goods_in_stock__c);
        }
        //  }
      }
    }

    List<Goods_in_stock__c> goodsInStockList = [SELECT id, (SELECT id FROM Consignment_notes__r) FROM Goods_in_stock__c WHERE id IN :listIds];

    for (Goods_in_stock__c gn_i : goodsInStockList) {
      gn_i.Count_of_childs__c = gn_i.Consignment_notes__r.size();
    }
    update goodsInStockList;
  }
}