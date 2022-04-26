trigger ConsigmentNoteTrigger on Consignment_note__c(
  before insert,
  before update,
  after insert,
  after delete,
  after update
) {
  if (Trigger.isBefore && Trigger.isUpdate) {
    ConsigmentNoteTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
  } else if (Trigger.isAfter && Trigger.isDelete) {
    ConsigmentNoteTriggerHandler.afterDelete(Trigger.oldMap);
  } else if (Trigger.isAfter && Trigger.isInsert) {
    ConsigmentNoteTriggerHandler.afterInsert(Trigger.new);
  } else if (Trigger.isAfter && Trigger.isUpdate) {
    ConsigmentNoteTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
  }
}
