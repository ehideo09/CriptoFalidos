({
    handleClick : function(component, event, helper) {
        var uName = component.get('v.nome'); /* Pega a variavel da view (.cmp). Não precisa do ! */
        alert("Bem vindo " + uName);
        component.set('v.nome', 'World'); /*Seta valor na view*/
        
    }
})
