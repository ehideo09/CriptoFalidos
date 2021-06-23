public with sharing class ExampleBatchable implements Database.Batchable<SObject> {
    public ExampleBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext info){ 
        return Database.getQueryLocator('SELECT id, Revisao__c FROM HistoricodePreco__c'); 
    }     

    public void execute(Database.BatchableContext info, List<HistoricodePreco__c> scope)
    {
        for (HistoricodePreco__c hp : scope) {
            
            if(hp.Revisao__c == null){
                hp.Revisao__c = 0;
            }
            else {
                hp.Revisao__c++;
            }
        }

        update scope; 
    }     
    public void finish(Database.BatchableContext info){     
    } 
}
