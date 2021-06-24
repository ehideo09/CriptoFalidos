public class BinanceAPI //with sharing - Obedece os rules do salesforce - without sharing libera o acesso aos dados
{
    @AuraEnabled //Libera o metodo para o JavaSript e o metodo deve ser estatico
    public static string getPrice(string mercadoId)
    {
        Mercado__c mercado = [SELECT Id, MoedaPrimaria__c, MoedaSecundaria__c 
                              FROM Mercado__c  
                              WHERE ID = :mercadoId ];

        string pair = mercado.MoedaPrimaria__c + mercado.MoedaSecundaria__c;
        pair = pair.replace('USD', 'USDT');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price?symbol=' + pair);
        request.setMethod('GET');
        HttpResponse response = http.send(request);     

        if (response.getStatusCode() == 200) {
            SymbolPrice sp = (SymbolPrice)JSON.deserializeStrict(response.getBody(), SymbolPrice.class);
            
            return sp.price;
        }
        else {
            return 'Erro ao acessar a API da Binance';
        }
    }

    @AuraEnabled //Libera o metodo para o JavaSript e o metodo deve ser estatico
    public static List<SymbolPrice> getAllMercadoPrice()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price');
        request.setMethod('GET');
        HttpResponse response = http.send(request);     
        
        if (response.getStatusCode() == 200) {
            List<SymbolPrice> spList = (List<SymbolPrice>)JSON.deserializeStrict(response.getBody(), List<SymbolPrice>.class);
            return spList; 
        }
        else {
            return null;
        }
    }

    public Class SymbolPrice
    {
        public string symbol {get;set;}
        public string price {get;set;}
    }

    @AuraEnabled
    public static string getRecordTypeId(String ordemType){
        String rTypeId = Schema.SObjectType.Ordem__c.getRecordTypeInfosByDeveloperName().get(ordemType).getRecordTypeId();
        return rTypeId;

    }
}