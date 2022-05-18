import {LightningElement,track}from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAnimalList from '@salesforce/apex/AnimalListHeandler.getAnimalList';
import getAnimalFromApi from '@salesforce/apex/AnimalListHeandler.getAnimalFromApi';
import postAnimal from '@salesforce/apex/AnimalListHeandler.postAnimal';

const recordMetadata = {
    name: 'name',
    says: 'says',
    eats: 'eats',
    id: 'id',
};

const columns = [{
    label: 'Name',
    fieldName: 'name'
}, {
    label: 'Says__c',
    fieldName: 'says'
}, {
    label: 'Eat__c',
    fieldName: 'eats'
}, {
    label: 'Id__c',
    fieldName: 'id'
}, ];
export default class HelloWorld extends NavigationMixin(LightningElement) {
    columns = columns;
    @track isModalOpen = false;
    @track inputDisabled = true;
    @track name = '';
    data = [];
    animalData = []
    id = '';
    says = '';
    eats = '';
    message;
    variant;

    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    submitDetails() {
        this.isModalOpen = false;
    }

    animalInputDisabled() {
        if(this.name === ""){
            this.inputDisabled = false;
        } else this.inputDisabled = true;
    }

    animalIdChange(event) {
        this.id = event.target.value;
        getAnimalFromApi({id: this.id})
        .then(result => {
            console.log(result);
            const animal = JSON.parse(result, recordMetadata);
            this.name = animal.name;
            this.eats = animal.eats;
            this.says = animal.says;
            this.animalInputDisabled();
        })
    }
    animalNameChange(event) {
        this.name = event.target.value;
    }
    animalSaysChange(event) {
        this.says = event.target.value;
    }
    animalEatsChange(event) {
        this.eats = event.target.value;
    }
    
    saveAnimal() {
        let animalData = {
            "animal": {
                "id": this.id,
                "name": this.name,
                "eats": this.eats,
                "says": this.says
            }
        }
        postAnimal({animal: JSON.stringify(animalData)})
        .then(() => {
            this.message = 'Successful'
            this.variant = 'success'
            this.showNotification();
    })
        .catch(() => {
            this.message = 'Error'
            this.variant = 'error'
            this.showNotification();
        })
        this.closeModal();
    }

    showNotification() {
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
    }

    navigateToNewContactWithDefaults() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Animal__c',
                actionName: 'new'
            },
        });
    }
   
    connectedCallback() {
        getAnimalList().then(result => {
            const data = JSON.parse(result, recordMetadata);
            this.data = data;
        }).catch(
            console.log('error')
        );
    }
}