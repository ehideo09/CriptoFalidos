({
    retrievePrice : function(component, event, helper) {
        var action = component.get("c.getPrice");
        action.setParams({
            "mercadoId" : component.get("v.recordId")
        });

        action.setCallback(this, function(response){
            var state = response.getState(); //Pega o retorno do response
            
            if(state == "SUCCESS"){
                component.set('v.opCotacaoReal', response.getReturnValue()); /*Seta valor na view*/
            }
            else{
                component.set('v.opCotacaoReal', 'Erro ao consultar a cotação.'); /*Seta valor na view*/
            }
        });

        $A.enqueueAction(action); //Dispara a ação
    },
    handleOrdem : function(component, event, helper) {
        alert("Codigo da ordem");
    },
    handleChange : function(component, event, helper) {    
        component.set('v.opMercado', !event.getParam("checked")); /*Seta valor na view*/
    },
})