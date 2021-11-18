@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {

        list<account>accUpdate = new list<account>();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Blob bB = request.requestBody;
        JSONParser parser = JSON.createParser(request.requestBody.toString());
        wrapperWebhook wWh;
        
        system.debug(bB.toString());
        list<account> accList = [select name,id,description from account where Id ='0015j000009oNmkAAE'];
        for(account acc:accList){
        acc.Description= bB.toString();
        accUpdate.add(acc);}
        //System.debug('acc::::',bB.toString());
        update accUpdate;
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('got','thanks') ));
        //System.debug('acc::::', acc);

    }

    global class SFDCResponse{
        global string response;
        global string message;
        global SFDCResponse(string response,string message){
            response = response;
            message = message;
        }
    }
    global class wrapperWebhook{
        global string responseValue;
        global wrapperWebhook(string responseValue){
            responseValue = responseValue;
        }
        
    }
}
