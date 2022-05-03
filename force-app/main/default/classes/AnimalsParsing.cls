public with sharing class AnimalsParsing {

    public AnimalsParsing(){
    
    }

    public animal animal;

    public class animal {
    public String id;
    public String name;
    public String eats;
    public String says;
    }

    public static AnimalsParsing parse(String json) {
        return (AnimalsParsing) System.JSON.deserialize(json, AnimalsParsing.class);
    }
}
