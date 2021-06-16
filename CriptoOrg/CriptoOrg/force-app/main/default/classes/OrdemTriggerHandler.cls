public with sharing class OrdemTriggerHandler extends TriggerHandler
{
    public OrdemTriggerHandler() {}

    protected override void beforeInsert()
    {
        for (Ordem__c o : (List<Ordem__c>) trigger.New) 
        {
            OrdemDomain ordemDomain = new OrdemDomain(o);

            if(ordemDomain.getTotal() == null){ ordemDomain.recalculaTotal(); }
            else { ordemDomain.recalculaQuantidade(); }
        }
    }

    protected override void beforeUpdate()
    {
        for (Ordem__c o : (List<Ordem__c>) trigger.New) 
        {
            OrdemDomain ordemDomain = new OrdemDomain(o);
            Ordem__c ordemOld = (Ordem__c)trigger.oldMap.Get(o.Id);

            if(ordemDomain.isFieldDifferent(Schema.Ordem__c.Total__c, ordemOld)) 
                { o.adderror('O Total não pode ser alterado manualmente depois que a ordem foi criada.'); }
            
            if((OrdemDomain.isFieldDifferent(Schema.Ordem__c.Quantidade__c, ordemOld )) || (OrdemDomain.isFieldDifferent(Schema.Ordem__c.Preco__c, ordemOld )))
                { ordemDomain.recalculaTotal(); }
            
            o.QuantidadeP__c = o.Tipo__c == 'Venda' ? o.Quantidade__c * -1 : o.Quantidade__c;
        }
    }
}