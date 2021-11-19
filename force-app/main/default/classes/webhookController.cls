@RestResource(urlMapping='/api/webhook/pushDetailsdemo/*')
global with sharing class webhookController {
    @HttpPost
    global static void webhookController() {

        list<account>accUpdate = new list<account>();
        string exce;
        string exce1;
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        Blob bB = request.requestBody;

        JSONParser parser = JSON.createParser(request.requestBody.toString());
        pusher ps;
        
        system.debug('bolb Vaue ::::'+bB.toString());
        exce1 = request.requestBody.toString();
        while(parser.nextToken() !=null){
            if(parser.getText() == 'pusher'){
                parser.nextToken();
                ps = (pusher)parser.readValueAs(pusher.class);
                System.debug('ps1' +ps);
            }
        }
        /*list<account> accList = [select name,id,description from account where Id ='0015j000009oNmkAAE'];
        for(account acc:accList){
        acc.Description= ps!=null?ps.name:''+ ps!=null?ps.email:'';
        accUpdate.add(acc);}
        //System.debug('acc::::',bB.toString());
        update accUpdate;*/
        account a = new account();
        a.Website = ps!=null?ps.email:'';
        a.Name = ps!=null?ps.name:'';
        a.Description = exce1;
        list<account>existsacc = [select name,id from account where name =: ps.name];
        string allstring = string.join(existsacc,',');
        if(existsacc.size()>0){
            response.statusCode = 401;
            response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('failed','account already exists')));
        }
        else {
            try{
                insert a;
                system.debug(a);
                response.statusCode = 200;
                response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('got',allstring+'==>'+a.name+'==>'+ps.name+'===>'+ps.email)));
            }
            catch(Exception e){
                System.debug('logLevel' +e.getMessage());
                exce = e.getMessage();
                response.statusCode = 401;
                response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('faileddeu',exce)));
                
                }
        }
        /*try{
            if(existsacc.size()>0){
                response.statusCode = 401;
                response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('failed','account already exists')));
            }else{
        insert a;
        system.debug(a);
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('got',ps.name+ps.email)));}
        }
        catch(Exception e){
        System.debug('logLevel' +e.getMessage());
        exce = e.getMessage();
        response.statusCode = 401;
        response.responseBody = Blob.valueOf(JSON.serialize(new SFDCResponse('failed',exce)));
        
        }*/

        //Syst,em.debug('acc::::', acc);

    }

    global class SFDCResponse{
         string response;
         string message;
        global SFDCResponse(string response1,string message1){
            response = response1;
            message = message1;
        }
    }
    global class pusher{
        global string name;global string email;
        global pusher(string name,string email){
            name = name;email=email;

        }
        
    }
}
