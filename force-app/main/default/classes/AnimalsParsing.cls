global with sharing class AnimalsParsing {

    global AnimalsParsing(){
    
    }

    global animal animal;

    global class animal {
    global String id;
    global String name;
    global String eats;
    global String says;
    }

    global static AnimalsParsing parse(String json) {
        return (AnimalsParsing) System.JSON.deserialize(json, AnimalsParsing.class);
    }

    public static List<animal> parseList(String json) {
        return (List<animal>) System.JSON.deserialize(json, List<animal>.class);
    }
}
