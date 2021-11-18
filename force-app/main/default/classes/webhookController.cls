@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {

        list<account>accUpdate = new list<account>();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Blob bB = request.requestBody;
        JSONParser parser = JSON.createParser(request.requestBody.toString());
        pusher ps;
        
        system.debug(bB.toString());

        while(parser.nextToken()!=null){
            if(parser.getText() == 'pusher'){
                parser.nextToken();
                ps = (pusher)parser.readValueAs(pusher.class);
            }
        }
        list<account> accList = [select name,id,description from account where Id ='0015j000009oNmkAAE'];
        for(account acc:accList){
        acc.Description= ps!=null?ps.name:''+ ps!=null?ps.email:'';
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
    global class pusher{
        global string name;global string email;
        global pusher(string name,string email){
            name = name;email=email;

        }
        
    }
}
