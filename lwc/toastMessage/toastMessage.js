import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastMessage extends LightningElement {

 @api myTitle = 'I am coming';

 //@api OnclickOfThis(){
   //  this.myTitle= 'I am changing'
 //}

  @api OnhandleClick(){
       this.showToast(this.myTitle);

    }

    showToast(passing) {
        const event = new ShowToastEvent({
            title: 'Sawdhan' +passing,
            message: 'Gabbar a rha hai',
            variant: 'success',
            //mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}