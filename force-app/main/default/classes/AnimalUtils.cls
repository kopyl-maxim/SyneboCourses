public with sharing class AnimalUtils {

    public static AnimalsParsing animalRequestParsing(String Ids) {
        AnimalsParsing animPars = new AnimalsParsing();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Ids);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            animPars = AnimalsParsing.parse(response.getBody());
        } 
        return animPars;
    }
}
