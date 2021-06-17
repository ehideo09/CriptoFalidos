trigger MercadoTrigger on Mercado__c (after update) {

    new MercadoTriggerHandler().run();
}