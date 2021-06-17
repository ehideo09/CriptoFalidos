public with sharing class MercadoTriggerHandler extends TriggerHandler 
 {
    public MercadoTriggerHandler() {}
           

    protected override void afterUpdate()
    {
        //this.ExecutaOrdemValdemort();
    }

    
    private void executaOrdemValdemort()
    {
        // Desenvolvedor Salesfoce Voldemorte
        Mercado__c merc = (Mercado__c)trigger.New[0];
        List<Ordem__c> OrdemList = [SELECT Id, Preco__c, Status__c FROM Ordem__c WHERE Mercado__c = :merc.id AND status__c = 'Aguardando'];
        
        for(Ordem__c ord : OrdemList)
        {
            if(ord.status__c == 'Aguardando')
            {
                Mercado__c mercadoOld = (Mercado__c)trigger.oldMap.Get(merc.Id);
                double precoAntigo = mercadoOld.CotacaoAtual__c;
                double precoOrdem = ord.preco__c;
                double preconovo = merc.CotacaoAtual__c;
        
                if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
                {
                    ord.status__c = 'Executada';
                    update ord;
                }
            }
        }
    }

    private void executaOrdemTalvez()
    {
        Map<id, Ordem__c> mapOrdem = new Map<id, Ordem__c>();

        for (Mercado__c merc : (List<Mercado__c>)trigger.new) {
            
            List<Ordem__c> OrdemList = [SELECT Id, Preco__c, Status__c FROM Ordem__c WHERE Mercado__c =: merc.id AND Status__c = 'Aguardando'];

            for(Ordem__c ord : OrdemList)
            {
                Mercado__c mercadoOld = (Mercado__c)trigger.oldMap.Get(merc.Id);
                double precoAntigo = mercadoOld.CotacaoAtual__c;
                double precoOrdem = ord.preco__c;
                double preconovo = merc.CotacaoAtual__c;
            
                if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
                {
                    ord.status__c = 'Executada';
                    update ord;
                }    
            }
        }     
    }

    private void executaOrdemFinal()
    {
        List<Mercado__c> mercadoList = [SELECT Id, CotacaoAtual__c, (SELECT Id, Preco__c, Status__c FROM Ordens__r WHERE Status__c = 'Aguardando')
                                        FROM Mercado__c
                                        WHERE Id IN :trigger.newMap.keySet()];

        List<Ordem__c> updateOrdemList = new List<Ordem__c>();

        for(Mercado__c mercado : mercadoList)
        {
            for(Ordem__c ordem : mercado.Ordens__r)
            {
                Mercado__c mercadoOld = (Mercado__c)trigger.oldMap.Get(mercado.Id);
                double precoAntigo = mercadoOld.CotacaoAtual__c;
                double precoOrdem = ordem.preco__c;
                double preconovo = mercado.CotacaoAtual__c;
            
                if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
                {
                    updateOrdemList.add(new Ordem__c(Id = ordem.Id, Status__c = 'Executada'));
                }    
            }
        }

        update updateOrdemList;
    }

}
