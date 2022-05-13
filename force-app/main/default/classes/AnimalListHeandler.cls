public with sharing class AnimalListHeandler {
    @AuraEnabled(cacheable = true)
    public static String getAnimalList() {
        List<Animal__c> animal = [SELECT id, Id__c, Name, Eat__c, Says__c FROM Animal__c];
        String str = JSON.serialize(AnimlaRestResourses.parseAnimalList(animal)); 
        return str;
    }
}
