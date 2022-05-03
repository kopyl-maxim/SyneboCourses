public class AnimalsQueueable implements Queueable, Database.AllowsCallouts {

    private Set<id> animalIdSet;

    public AnimalsQueueable(Set<id> animalIdSet){
        this.animalIdSet = animalIdSet;
    }

    public void execute(QueueableContext context){
        List<Animal__c> animalToUpdateList = new List<Animal__c>();
        Map<id, Animal__c> animalMap = new Map<id, Animal__c>([SELECT id, Id__c FROM Animal__c WHERE id IN : animalIdSet]);
        Integer intAnim = 50;
        Integer i = 0;

        for (id animalId : animalMap.keySet()){
            i++;
            animalToUpdateList.add(animalMap.get(animalId));
            animalMap.remove(animalId);

            if (i == intAnim) {
                break;
            }
        }

        for(Animal__c animal : animalToUpdateList){
                AnimalsParsing animPars = AnimalUtils.animalRequestParsing(animal.Id__c);
                if (animPars.animal == null){
                    continue;
                }
                animal.Eat__c = animPars.animal.eats;
                animal.Says__c = animPars.animal.says;
                animal.Name = animPars.animal.name;
        }

        update animalToUpdateList;
        if (animalMap.size() > 0 && !Test.isRunningTest() ){
            System.enqueueJob(new AnimalsQueueable(animalMap.keySet()));
        }
    }
}