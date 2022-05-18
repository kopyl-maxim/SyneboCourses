public with sharing class AnimalListHeandler {
    @AuraEnabled(cacheable = true)
    public static String getAnimalList() {
        List<Animal__c> animal = [SELECT id, Id__c, Name, Eat__c, Says__c FROM Animal__c];
        String str = JSON.serialize(AnimlaRestResourses.parseAnimalList(animal)); 
        return str;
    }

    @AuraEnabled(cacheable = true)
    public static String getAnimalFromApi(String id) {
            System.debug('animal id ' + id);
            AnimalsParsing animPars = AnimalUtils.animalRequestParsing(id);
                String str = JSON.serialize(animPars.animal);
                return str;
        } 

    @AuraEnabled(cacheable = false)
    public static void postAnimal(String animal) {
            AnimalsParsing animalJson = (AnimalsParsing) JSON.deserialize(animal, AnimalsParsing.class);
            Animal__c anim = new Animal__c(Id__c = animalJson.animal.id, Name = animalJson.animal.name, Eat__c = animalJson.animal.eats, Says__c = animalJson.animal.says );
            insert anim;
        } 
    }
