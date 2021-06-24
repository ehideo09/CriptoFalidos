public class VFOrdemController {
    
    public List<Ordem__c> ordemList { get;set;}
    public List<BinanceAPI.SymbolPrice> priceList { get;set;}
    public String cotacaoAtual { get;set;}
    
    public VFOrdemController(){
    

    }

    public VFOrdemController(ApexPages.StandardController controller){
        Mercado__c mercado = (Mercado__c)controller.getRecord(); //Pega todos os objetos de mercado vindo da controller

        this.ordemList = [SELECT Id, Name, OperacaoMercado__c, Preco__c, toLabel(Tipo__c), Status__c, Quantidade__c, Total__c, Validade__c  
                                    FROM Ordem__c 
                                    WHERE Mercado__c =: mercado.Id];


        for (Ordem__C o : ordemList) {
            o.Quantidade__c.setScale(6);
            o.Preco__c.setScale(6);
        }     

        cotacaoAtual = BinanceAPI.getPrice(mercado.Id);

        priceList = BinanceAPI.getAllMercadoPrice();
    }
}
