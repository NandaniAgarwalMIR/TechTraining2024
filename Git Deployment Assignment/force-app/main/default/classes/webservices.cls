@RestResource(urlMapping = '/Contact/ContactServices/*')
global with sharing class webservices{
    @HttpGet
    
    global static Contact getContactById(){
        RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        try{
            Contact con = [Select Id, Name, Phone from Contact where Id = :contactId];
            return con;
        }catch(DMLException e){
            System.debug(e.getMessage());
            return null;
        }
    }
    @HttpPost
    global static Contact createContact(String name, String phone){
        try{
            Contact con = new Contact(LastName = name, Phone = phone);
            insert con;
            return con;
        }catch(DMLException e){
            System.debug(e.getMessage());
            return null;
        }
    }
    @HttpDelete
    global static void deleteContact(){
        RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        try{
            Contact con = [Select Id from Contact where Id = :contactId];
            delete con;
        }catch(DMLException e){
            System.debug(e.getMessage());
        }
    }
    @HttpPut
    global static void upsertContact(String id, String name, String phone){
        try{
            Contact con = new Contact(Id = id, FirstName = name, Phone = phone);
            upsert con;
        }catch(DMLException e){
            System.debug(e.getMessage());
        }
    }
    @HttpPatch
    global static Id updateContact(){
        RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        try{
            Contact con = [Select Id from Contact where Id = :contactId];
            Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
            for(String fieldName : params.keySet()){
                con.put(fieldName, params.get(fieldName));
            }
            update con;
            return con.Id;
        }catch(DMLException e){
            System.debug(e.getMessage());
            return null;
        }
    }
}