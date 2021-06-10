public with sharing class OrdemTriggerHandler extends TriggerHandler
{
    public OrdemTriggerHandler() {}

    protected override void beforeInsert()
    {
        for (Ordem__c o : (List<Ordem__c>) trigger.New) 
        {
            Ordem__c ordemFoda = o;
            
            /*Caculo do Total*/
            if(ordemFoda.Total__c == null)
            {
                if(ordemFoda.Preco__c != null && ordemFoda.Quantidade__c != null){
                    ordemFoda.Total__c = ordemFoda.Quantidade__c * ordemFoda.Preco__c;
                }
                else {
                    ordemFoda.adderror('Os valores de quantidade e preço não foram preenchidos.');
                }
            }
            //Calculo da quantidade
            else 
            {
                if(ordemFoda.Preco__c != null)
                {
                    ordemFoda.Quantidade__c = ordemFoda.Total__c / ordemFoda.Preco__c;
                }
                else 
                {
                    ordemFoda.adderror('Os valores de preço não foi preenchido.');
                }
            }
            
        }
    }

    protected override void beforeUpdate()
    {
        for (Ordem__c o : (List<Ordem__c>) trigger.New) 
        {
            Ordem__c ordemFoda = o;
            
            Ordem__c ordemFodaOld = (Ordem__c)trigger.oldMap.Get(ordemFoda.Id);

            if(ordemFoda.Quantidade__c != null && ordemFoda.Preco__c != null)
            {
                /*Se o total foi alterado em disparidade com o preco e quantidade*/
                if(ordemFoda.Total__c != ordemFodaOld.Total__c && ordemFoda.Total__c != (ordemFoda.Quantidade__c * ordemFoda.Preco__c))
                {
                    /*Retorna mensagem de erro*/
                    ordemFoda.adderror('O Total não pode ser alterado manualmente.');
                }

                /*Se a quantidade ou o preço foram alterados*/
                if((ordemFoda.Quantidade__c != ordemFodaOld.Quantidade__c)
                    || (ordemFoda.Preco__c != ordemFodaOld.Preco__c))
                {
                    /*Recalcular o Total*/
                    ordemFoda.Total__c = ordemFoda.Quantidade__c * ordemFoda.Preco__c;
                }
            }
            else {
                ordemFoda.adderror('A quantidade ou o preço não foi preenchido.');
            }

            ordemFoda.QuantidadeP__c = ordemFoda.Tipo__c == 'Venda' ? ordemFoda.Quantidade__c * -1 : ordemFoda.Quantidade__c;
        }
    }
}
