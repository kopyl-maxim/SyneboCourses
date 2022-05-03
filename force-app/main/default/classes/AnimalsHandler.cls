public class AnimalsHandler {
    public static void afterInsert(List<Animal__c> newList) {
        Set<id> animalIdSet = new Set<id>();
        for (Animal__c anim : newList){
            if(anim.Id__c != null){
                animalIdSet.add(anim.id);
            }
        }
        if(!animalIdSet.isEmpty()){
            System.enqueueJob(new AnimalsQueueable(animalIdSet));
        }
    }
    
    public static void afterUpdate(List<Animal__c> newList, Map<Id, Animal__c> oldMap) {
        Set<id> animalIdSet = new Set<id>();
        for (Animal__c anim : newList){
            if(anim.Id__c != oldMap.get(anim.id).Id__c){
                animalIdSet.add(anim.id);
             }
        }
        if(!animalIdSet.isEmpty()){
            System.enqueueJob(new AnimalsQueueable(animalIdSet));
        }
    }
}