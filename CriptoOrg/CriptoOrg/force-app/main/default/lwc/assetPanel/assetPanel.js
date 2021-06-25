import { LightningElement, wire } from 'lwc';
import getPriceFiltered from '@salesforce/apex/BinanceAPI.getPriceFiltered';
import getAllMercadoPrice from '@salesforce/apex/BinanceAPI.getAllMercadoPrice';

const columns = [
    { label: 'Ativo', fieldName: 'symbol', type: 'text' },
    { label: 'Preço', fieldName: 'price', type: 'text', cellAttributes:{aligment:'text'} },
];

export default class AssetPanel extends LightningElement {

    data = [];
    columns = columns;
    searchKey='';
    isLoading = true;

    @wire(getAllMercadoPrice, {}) setData({error, data}){
        
        if(data){
            this.data = data;
            this.isLoading = false;
        }
        else if(error){
            console.log('Erro ao buscar os dados.' + error);
            this.isLoading = false;
        }

        
    }

    @wire(getPriceFiltered, {searchKey:"$searchKey"}) setFilteredData({error, data}){
        
        if(data){
            this.data = data;
            this.isLoading = false;
        }
        else if(error){
            console.log('Erro ao buscar os dados.' + error);
            this.isLoading = false;
        }
    }

    handleKeyChange(event){
        window.clearTimeout(this.delayTimeout);

        this.isLoading = true;

        const searchKey = event.target.value; //Pega o valor do campo

        this.delayTimeout = setTimeout(() => {
            this.isLoading = true;
            this.searchKey = searchKey;            
        }, 500)

        
    }

}