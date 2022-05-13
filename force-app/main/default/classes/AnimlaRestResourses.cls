@RestResource(urlMapping='/Animal/*')
global without sharing class AnimlaRestResourses {
    @HttpGet
    global static String animalGet(){
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1);
        return JSON.serializePretty(parseAnimalList([SELECT Name, Eat__c, Says__c, Id__c FROM Animal__c WHERE Id__c = : animalId]));
    }

    public static List<AnimalsParsing.animal> parseAnimalList(List<Animal__c> animal){
        List<AnimalsParsing.animal> animalList = new List<AnimalsParsing.animal>();
        for (Animal__c anim_i : animal){
            AnimalsParsing.animal animalForList = new AnimalsParsing.animal();
            animalForList.id = anim_i.;
            animalForList.eats = anim_i.Eat__c;
            animalForList.says = anim_i.Says__c;
            animalForList.name = anim_i.Name;
            animalList.add(animalForList);
        }
        return animalList;
    }

    @HttpPost
    global static String animalPost(String id) {
        AnimalsParsing animPars = AnimalUtils.animalRequestParsing(id);
        Animal__c anim = new Animal__c(Id__c = id, Name = animPars.animal.Name, Eat__c = animPars.animal.eats, Says__c = animPars.animal.says );
        insert anim;

        return anim.ID;
    }   
}
