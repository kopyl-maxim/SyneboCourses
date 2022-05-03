@isTest
public class AnimalsCalloutMock implements HttpCalloutMock{
    public HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"animal":{"id":1,"name":"testName","eats":"testEats","says":"testSays"}}');
        res.setStatusCode(200);
        return res;
    }
}