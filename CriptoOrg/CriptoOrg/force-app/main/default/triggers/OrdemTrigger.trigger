trigger OrdemTrigger on Ordem__c (before insert, before update) //before ou after -- insert, update, delete, undelete (after)
{
    new OrdemTriggerHandler().run();
}