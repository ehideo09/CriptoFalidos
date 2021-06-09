trigger OrdemTrigger on Ordem__c (before insert) //before ou after -- insert, update, delete, undelete (after)
{
    for(Ordem__c o : Trigger.New)
    {
        o.adderror('Hello Word');
        
    }
        
}