public with sharing class HistoricoPrecoTriggerHandler extends TriggerHandler 
{
    public HistoricoPrecoTriggerHandler() {}

    protected override void afterInsert()
    {
        this.updateMercadoCotacaoAtual();

    }

    private void updateMercadoCotacaoAtual()
    {
        /*Map<id, double> mapPrecos = new Map<id, double>();
        List<Mercado__c> mercadoUpdList = new List<Mercado__c>();

        for (HistoricodePreco__c hp : (List<HistoricodePreco__c>)trigger.new) 
        {
            mapPrecos.put(hp.Mercado__C, hp.Preco__c);
        }

        for (Id mId : mapPrecos.keySet()) 
        {
            mercadoUpdList.add(new Mercado__c(id= mId, CotacaoAtual__c = mapPrecos.get(mId)));
        }
        
        if(mercadoUpdList.size() > 0 && Schema.sObjectType.Mercado__c.isUpdateable())  
        { update mercadoUpdList; }*/

        Map<id, Mercado__c> mapMercado = new Map<id, Mercado__c>();
        for (HistoricodePreco__c hp : (List<HistoricodePreco__c>)trigger.new) 
        {
            mapMercado.put(hp.Mercado__C, new Mercado__C(id = hp.Mercado__c, CotacaoAtual__c = hp.Preco__c));
        }

        update mapMercado.values();

    }
}