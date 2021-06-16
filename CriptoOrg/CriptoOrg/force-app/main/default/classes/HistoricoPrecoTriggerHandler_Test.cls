@isTest
private class HistoricoPrecoTriggerHandler_Test {
    public HistoricoPrecoTriggerHandler_Test() {

    }

    @isTest
    static void insertHistoricoPreco(){

        Mercado__c newMercado = new Mercado__c(Name='KGB/BRL', Nivel_Risco__c = 'Baixo');

        insert newMercado;

        Double primeiroPreco = 7.50;
        Double ultimoPreco = 14.50;

        List<HistoricodePreco__c> insertHistList = new List<HistoricodePreco__c>();

        while (primeiroPreco <= ultimoPreco) {

            insertHistList.add(new HistoricodePreco__c(
                                                        Mercado__c = newMercado.Id,
                                                        Preco__c = primeiroPreco)
            );

            primeiroPreco += 0.50;
        }

        Test.startTest();

        insert insertHistList;

        Test.stopTest();

        Mercado__c mercado = [SELECT CotacaoAtual__c FROM Mercado__c WHERE id = :newMercado.Id LIMIT 1];                              

        System.assertEquals(mercado.CotacaoAtual__c, ultimoPreco, 'Sucesso');

    }
}
