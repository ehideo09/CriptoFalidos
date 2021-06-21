public with sharing class OrdemController {
    @AuraEnabled
    public static List<Ordem__c> getOrdemLits(string mercadoId){
        return [SELECT Id, Name, OperacaoMercado__c, Preco__c, Tipo__c, Status__c, Total__c, Validade__c 
                FROM Ordem__c WHERE Mercado__c =: mercadoId Order By CreatedDate DESC];
    }
}
