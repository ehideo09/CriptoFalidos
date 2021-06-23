public with sharing class SchedulerGetPrecoHelper {
    public SchedulerGetPrecoHelper() {}

    @future (callout=true)
    public static void AtualizaCotacaoAtualTodosMercadosAtivos()
    {
        Map<string, double> mapSymbolPrice = new Map<string, double>();

        List<BinanceAPI.SymbolPrice> spList = BinanceAPI.getAllMercadoPrice();

        for (BinanceAPI.SymbolPrice sp : spList) {
            mapSymbolPrice.put(sp.symbol,  Double.valueOf(sp.price));
        }

        List<Mercado__c> mercadoList = [SELECT name, ContinuousName__c, CotacaoAtual__c from Mercado__c WHERE Ativo__c = true
                                        AND ContinuousName__c IN : mapSymbolPrice.keySet()];

        for (Mercado__c merc : mercadoList) {
            
            merc.CotacaoAtual__c = mapSymbolPrice.get(merc.ContinuousName__c);
        }


        update mercadoList;

    }
}
