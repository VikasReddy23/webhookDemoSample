@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {

        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Blob bB = request.requestBody;
        JSONParser parser = JSON.createParser(request.requestBody.toString());
        wrapperWebhook wWh;
        
        //system.debug(bB.toString());
        account acc = new account();
        acc.Id ='0015j000009oNmkAAE';
        acc.Description= bB.toString();
        //System.debug('acc::::',bB.toString());
        update acc;
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('got','thanks') ));
        System.debug('acc::::',acc);

    }

    global class wrapperWebhook{
        global string responseValue;
        global wrapperWebhook(string responseValue){
            responseValue = responseValue;
        }
        
    }
}
