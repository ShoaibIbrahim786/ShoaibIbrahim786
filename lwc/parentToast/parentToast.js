import { LightningElement } from 'lwc';

export default class ParentToast extends LightningElement {

   
    OnhandleChange(){
        this.template.querySelector("c-toast-message").OnhandleClick();
    }
}