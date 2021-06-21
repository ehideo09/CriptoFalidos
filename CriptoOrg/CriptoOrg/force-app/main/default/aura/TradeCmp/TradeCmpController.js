({
    retrievePrice : function(component, event, helper) {
       helper.retrievePrice(component, event, helper); /* Usar a helper quando o metodo for usado mais vezes em utros lugares*/
    },
    tabSelected: function(component,event,helper) {
        alert(JSON.stringify(component.get("v.selTabId")));
    },
    handleChange : function(component, event, helper) {    
        component.set('v.opMercado', !event.getParam("checked")); /*Seta valor na view*/
        helper.retrievePrice(component, event, helper);
    },
    handleQuantPriceChange : function(component, event, helper) {
        var price = component.get("v.tradePrice");
        var quantidade = component.get("v.quantidade");
        var total = price * quantidade;

        component.set("v.total", total);
    },
    handleTotalChange : function(component, event, helper) {
        var price = component.get("v.tradePrice");
        var total = component.get("v.total");

        var quantidade = total / price;

        component.set("v.quantidade", quantidade);
    },
    handleOrdem : function(component, event, helper) {
        
        /*Evita a ação do botão*/
        event.preventDefault(); 
        
        /*Pega todos os campos da tela*/
        var fields = event.getParam("fields"); 
        
        var action = component.get("c.getRecordTypeId");
        action.setParams({
            "ordemType" : "Compra"//component.get("Compra")
        });

        action.setCallback(this, function(response){
            
            var state = response.getState(); //Pega o retorno do response
            
            if(state == "SUCCESS"){
                var rtId = response.getReturnValue();
                
                fields["RecordTypeId"] = rtId;
                
                if(fields["OperacaoMercado__c"] == false)
                    fields["Status__c"] = "Aguardando";
                else
                    fields["Status__c"] = "Executada";

                if(fields["Preco__c"] == undefined)
                {
                    fields["Preco__c"] = component.get("v.opCotacaoReal");
                }

                fields['CotacaoAtual__c'] = component.get("v.tradePrice");

                var dateTimeNow = new Date().toISOString();
                fields['DataCriacao__c'] = dateTimeNow;

                component.find('ordemForm').submit(fields);
            }
            else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action); /*Dispara a ação */
    },
    handleSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(
            {
                "title" : "Sucesso!",
                "message" : 'Registro inserido!',
                "type" : "success",
                "duration" : 3000
            }
        );

        toastEvent.fire();

        /*Limpa os campos*/
        component.find("ordField").forEach(function(f){
            f.reset();
        })

        //Pode atualizar a pagina ou navegar para o registro inserido
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
        //"recordId": component.get("v.recordId"), //Navega para o objeto principal
        "recordId": response.Id, //Navega para a pagina do objeto inserido
        "slideDevName": "related"
        });
        
        navEvt.fire();

        var ordemEvtAction = $A.get("e.c:OrdemEvent");
        ordemEvtAction.setParams({
            "Context" : "TradeCmp"
        });

        ordemEvtAction.fire();


    },
    hadleError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(
            {
                "title" : "Sucesso!",
                "message" : 'Registro inserido!',
                "type" : "error",
                "duration" : 3000
            }
        );

        toastEvent.fire();

        /*Limpa os campos*/
        component.find("ordField").forEach(function(f){
            f.reset();
        })
    },
  
})