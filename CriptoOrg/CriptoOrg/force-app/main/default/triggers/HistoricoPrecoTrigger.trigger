trigger HistoricoPrecoTrigger on HistoricodePreco__c (after insert) {

    new HistoricoPrecoTriggerHandler().run();

}