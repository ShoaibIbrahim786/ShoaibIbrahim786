import { LightningElement,wire,track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountSearchController.getAccounts';
import getAccounts1 from '@salesforce/apex/AccountSearchController1.getAccounts1';
export default class CustomLookupComp extends LightningElement {
    @track accountName = '';
    @track accountList = []; 
    @track accountName1 = '';
    @track accountList1 = [];       
    @track accountId; 
    @track accountId1; 
    @track isshow=false;
    @track messageResult=false;
    @track isShowResult = true;   
    @track showSearchedValues = false;   
    @wire(getAccounts, {actName:'$accountName'})
    retrieveAccounts ({error, data}) {
       this.messageResult=false;
       if (data) {
           // TODO: Error handling 
           console.log('data::'+data.length);
           if(data.length>0 && this.isShowResult){
               this.accountList = data;                
               this.showSearchedValues = true; 
               this.messageResult=false;
           }            
           else if(data.length==0){
               this.accountList = [];                
               this.showSearchedValues = false;
               if(this.accountName!='')
                   this.messageResult=true;               
           }  
               
       } else if (error) {
           // TODO: Data handling
           this.accountId =  '';
           this.accountName =  '';
           this.accountList=[];           
           this.showSearchedValues = false;
           this.messageResult=true;   
       }
   }
   @wire(getAccounts1, {actName1:'$accountName1'})
    retrieveAccounts ({error, data}) {
       this.messageResult=false;
       if (data) {
           // TODO: Error handling 
           console.log('data::'+data.length);
           if(data.length>0 && this.isShowResult){
               this.accountList1 = data;                
               this.showSearchedValues = true; 
               this.messageResult=false;
           }            
           else if(data.length==0){
               this.accountList1 = [];                
               this.showSearchedValues = false;
               if(this.accountName1!='')
                   this.messageResult=true;               
           }  
               
       } else if (error) {
           // TODO: Data handling
           this.accountId1 =  '';
           this.accountName1 =  '';
           this.accountList1=[];           
           this.showSearchedValues = false;
           this.messageResult=true;   
       }
   }
   handleClick(event){
    this.isShowResult = true;   
    this.messageResult=false;        
  }
   handleClick1(event){
    this.isShowResult = true;   
    this.messageResult=false;        
  }
  handleKeyChange(event){       
    this.messageResult=false; 
    this.accountName = event.target.value;
  } 

   handleKeyChange1(event){       
    this.messageResult=false; 
    this.accountName1 = event.target.value;
  }  

  handleParentSelection(event){        
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult=false;
    //Set the parent calendar id
    this.accountId =  event.target.dataset.value;
    //Set the parent calendar label
    this.accountName =  event.target.dataset.label;      
    console.log('accountId::'+this.accountId);    
    const selectedEvent = new CustomEvent('selected', { detail: this.accountId });
        // Dispatches the event.
    this.dispatchEvent(selectedEvent);    
}

 handleParentSelection1(event){        
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult=false;
    //Set the parent calendar id
    this.accountId1 =  event.target.dataset.value;
    //Set the parent calendar label
     this.accountName1 =  event.target.dataset.label;      
    console.log('accountId1::'+this.accountId1);    
    const selectedEvent1 = new CustomEvent('selected', { detail: this.accountId1 });
        // Dispatches the event.
    this.dispatchEvent(selectedEvent1);    
}

}