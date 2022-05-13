import { LightningElement, track } from 'lwc';
import getAnimalList from '@salesforce/apex/AnimalListHeandler.getAnimalList';
const recordMetadata = {

    name: 'name',
    says: 'says',
    eats: 'eats',
    id: 'id',
};

const columns = [
    { label: 'Name', fieldName: 'name' },
    { label: 'Says__c', fieldName: 'says'},
    { label: 'Eat__c', fieldName: 'eats'},
    { label: 'Id__c', fieldName: 'id'},
];


export default class HelloWorld extends LightningElement {
    @track error;
    data = [];
    columns = columns;

        connectedCallback() {
            getAnimalList()
                .then(result => {
                    console.log('true');
                    const data = JSON.parse(result, recordMetadata);
                    console.log('dataTest' + data);
                    this.data = data;
                })
                .catch(error => {
                    this.error = error;
                    console.log('error');
                });
        }
    }