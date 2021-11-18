@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

    }

    global class wrapperWebhook{
        global string responseValue;
        
    }
}
