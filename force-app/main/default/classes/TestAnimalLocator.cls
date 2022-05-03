@isTest 
private class TestAnimalLocator {
    @isTest static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalsHeandlerTest()); 
        Map<anim.id, anim> test = new Map<anim.id, anim>();
        insert anim;
        Test.startTest();
        HttpResponse strResp = AnimalsHandler.updateAnimalRecord(anim,  an);
        Test.stopTest();
        
        // Verify response received contains fake values
        String contentType = strResp.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = strResp.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, strResp.getStatusCode());
    }
}