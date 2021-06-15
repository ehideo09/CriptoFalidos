({
    retrievePrice : function(component, event, helper) {
        var action = component.get("c.getPrice");
        action.setParams({
            "mercadoId" : component.get("v.recordId")
        });

        action.setCallback(this, function(response){
            var state = response.getState(); //Pega o retorno do response
            
            if(state == "SUCCESS"){
                console.log(response.getReturnValue()); //Pega o valor
            }
            else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action); //Dispara a ação
    },
    handleOrdem : function(component, event, helper) {
        alert("Codigo da ordem");
    },
    handleChange : function(component, event, helper) {        
        console.log(event.getParam("checked"));
        component.set('v.opMercado', !event.getParam("checked")); /*Seta valor na view*/
    },
})
