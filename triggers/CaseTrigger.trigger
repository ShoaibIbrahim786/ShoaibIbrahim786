trigger CaseTrigger on Case (before insert, before update, after update) {
    
    if (CaseTriggerHandler.isTriggerActive('CaseTrigger')) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                CaseTriggerHandler.beforeInsert(Trigger.new);
            }
            if (Trigger.isUpdate) {
                CaseTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
            }
        }
        if (Trigger.isAfter) {
            if (Trigger.isUpdate) {
                CaseTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
    }

    
    /*CaseTriggerHandler handler = new CaseTriggerHandler(Trigger.isExecuting, Trigger.size);
    
    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            handler.OnBeforeInsert(trigger.New);
        }
        else {
            handler.OnAfterInsert(trigger.New);
        }
    }
    else if ( Trigger.isUpdate ) {
        if(Trigger.isBefore){
            handler.OnBeforeUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
        else{
            handler.OnAfterUpdate(trigger.New ,trigger.Old,Trigger.NewMap,Trigger.OldMap);
        }
    }*/

}