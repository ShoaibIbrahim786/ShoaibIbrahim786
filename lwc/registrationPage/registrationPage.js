import { LightningElement, track } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
//import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import createEmployee from '@salesforce/apex/createEmployee.createEmployee';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class RegistrationPage extends LightningElement {


    @track name = NAME_FIELD;
    //@track email = EMAIL_FIELD.fieldApiName;
    @track phone = PHONE_FIELD;
    rec = {
        Name : this.name,
        Email__c : this.email,
        Phone : this.Phone
    }

    handleNameChange(event) {
        this.rec.Name = event.target.value;
        console.log("name1", this.rec.Name);
    }
    
    handleEmailChange(event) {
        this.rec.Email__c = event.target.value;
        console.log("Email", this.rec.Email__c);
    }
    
    handlePhnChange(event) {
        this.rec.Phone = event.target.value;
        console.log("Phone", this.rec.Phone);
    }

    handleClick() {
        createEmployee({ hs : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Name = '';
                    this.rec.Email = '';
                    this.rec.Phone = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Employee created',
                            variant: 'success',
                        }),
                    );
                }
                
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }
}