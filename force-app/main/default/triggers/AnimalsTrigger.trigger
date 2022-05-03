trigger AnimalsTrigger on Animal__c (after insert, after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        AnimalsHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isAfter && Trigger.isInsert) {
        AnimalsHandler.afterInsert(Trigger.new);
    }

}