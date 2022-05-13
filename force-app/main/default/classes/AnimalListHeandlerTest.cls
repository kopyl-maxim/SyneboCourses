@isTest 
public with sharing class AnimalListHeandlerTest {
   @isTest public static void getAnimalListTest() {
        Animal__c animalTest = new Animal__c(Name='testName', Eat__c='test Eat', Id__c='1', Says__c='test Says');
        insert animalTest;

        String test = AnimalListHeandler.getAnimalList();

        List<AnimalsParsing.animal> listJson = (List<AnimalsParsing.animal>) JSON.deserialize(test, List<AnimalsParsing.animal>.class);
        System.assertEquals(listJson[0].name, 'testName');
    }
}
