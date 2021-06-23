@isTest
public  class Batch_Test {
    public Batch_Test() {

    }

    @isTest
    static void testBatch()
    {
        Mercado__c newMercado = new Mercado__c(id = 'a005e000002zyDEAAY', Name='TST/BRL', Nivel_Risco__c = 'Baixo');

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

        insert insertHistList;
        
        Test.startTest();

        Database.executeBatch(new ExampleBatchable());
        Database.executeBatch(new ExampleBatchable());

        Test.stopTest();
    }
}
