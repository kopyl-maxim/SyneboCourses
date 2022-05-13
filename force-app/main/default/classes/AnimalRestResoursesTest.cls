@isTest
public with sharing class AnimalRestResoursesTest {
    @isTest 
    public static void animalGetTest() {
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock());
        Animal__c animalTest = new Animal__c(Name='testName', Id__c='1', Eat__c='testEats', Says__c = 'testSays');
        insert animalTest;
        String recordId = animalTest.Id__c;

        RestRequest request = new RestRequest();
        request.requestURI = 'https://ap4.salesforce.com/services/apexrest/Accounts/' + recordId;
        request.httpMethod='GET';
        RestContext.request =  request;

        Test.startTest();
        String getAnimal = AnimlaRestResourses.animalGet();
        Test.stopTest();

        List<AnimalsParsing.animal> listJson = (List<AnimalsParsing.animal>) JSON.deserialize(getAnimal, List<AnimalsParsing.animal>.class);

        System.assertEquals(listJson[0].name, 'testName');
    }

    @isTest
    public static void animalPostTest() {
        Test.setMock(HttpCalloutMock.class, new AnimalsCalloutMock());
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        String JSONMsg = '{"id" : "1"}';


        Test.startTest();
        req.requestURI = '/services/apexrest/Animal';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serializePretty(JSONMsg));

        String getAnimal = AnimlaRestResourses.animalPost(JSONMsg);
        Test.stopTest();
        System.debug( 'test responce ' + getAnimal);

        List<Animal__c> newAnimalCreated = [SELECT Id, Name FROM Animal__c WHERE Id = : getAnimal];

        System.debug( 'test responce ' + newAnimalCreated);
        System.assert(!newAnimalCreated.isEmpty());
    }
}