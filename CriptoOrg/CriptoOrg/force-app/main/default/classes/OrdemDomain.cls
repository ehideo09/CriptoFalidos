public with sharing class OrdemDomain 
{
    private Ordem__c ordem;

    public Double  getTotal()
    {
        return ordem.Total__c;
    }

    public OrdemDomain(Ordem__c ordem) 
    {
        this.ordem = ordem;
    }

    public void recalculaTotal()
    {
        if(this.ordem.Preco__c != null && this.ordem.Quantidade__c != null){
            this.ordem.Total__c = this.ordem.Quantidade__c * this.ordem.Preco__c;
        }
        else {
            this.ordem.adderror('Os valores de quantidade e preço não foram preenchidos.');
        }
    }

    public void recalculaQuantidade()
    {
        if(this.ordem.Preco__c != null && this.ordem.Total__c != null)
        {
            this.ordem.Quantidade__c = this.ordem.Total__c / ordem.Preco__c;
        }
        else 
        {
            this.ordem.adderror('Os valores de preço não foi preenchido.');
        }
    }

    public boolean isFieldDifferent(sObjectField field, Ordem__c compareOrdem)
    {
        return this.ordem.get(field) != compareOrdem.get(field);
    }
}