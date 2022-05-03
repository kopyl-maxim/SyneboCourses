public with sharing class BatchAnimalHandler implements Database.Batchable<SObject>, Schedulable, Database.AllowsCallouts {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query ='Select Id__c, Name, Eat__c, Says__c from Animal__c';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Animal__c> scope){
        for (Animal__c anim : scope){
                AnimalsParsing animPars = AnimalUtils.animalRequestParsing(anim.Id__c);
                if (animPars.animal == null){
                    continue;
                }
                anim.Name = animPars.animal.name;
                anim.Eat__c = animPars.animal.eats;
                anim.Says__c = animPars.animal.says;
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC){}

    public void execute(SchedulableContext SC){
        Database.executeBatch(new BatchAnimalHandler());
    }
}