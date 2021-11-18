@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Blob bB = request.requestBody;
        system.debug(bB.toString());
        account acc;
        acc.Name= bB.toString();

        System.debug('acc::::',bB.toString());
        insert acc;
        System.debug('acc::::',acc);

    }

    global class wrapperWebhook{
        global string responseValue;
        
    }
}
