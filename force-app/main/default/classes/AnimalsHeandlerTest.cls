@isTest
public with sharing class AnimalsHeandlerTest {

    @isTest public static void animalsAffterInsert() {
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock());
        List<Animal__c> animalList = new List<Animal__c>();

        for(Integer i = 0; i<51; i++){
            Animal__c animalTest = new Animal__c(Name='test'+ i, Eat__c='test Eat', Id__c='1', Says__c='test Says');
            animalList.add(animalTest);
        }
        Test.startTest();

        insert animalList;

        Test.stopTest();
        
        List<Animal__c> animalNewList = [SELECT id, Name FROM Animal__c];

        System.debug('animalNewList ' + animalNewList[0].Name);
    }

    @isTest public static void animalAfterUpdate() {
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock());
        List<Animal__c> animalList = new List<Animal__c>();

        for(Integer i = 0; i<51; i++){
            Animal__c animalTest = new Animal__c(Name='test'+ i, Eat__c='test Eat', Id__c='1', Says__c='test Says');
            animalList.add(animalTest);
        }
        insert animalList;

        for (Animal__c animalUpdate : animalList){
            animalUpdate.Id__c = '2';
        }

        Test.startTest();

        update animalList;

        Test.stopTest();
        
        List<Animal__c> animalNewList = [SELECT id, Name FROM Animal__c];

        System.debug('animalNewList ' + animalNewList[0].Name);
    }
}