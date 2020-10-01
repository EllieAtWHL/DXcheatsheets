case 'Create Record':
                let targetDateJSON = new Date(this.targetdate).toJSON();
                let source = this.source;
                createMonthly({source: source, targetDateJSON: targetDateJSON})
                    .then(result => {
                        this.recordId = result;
                        this.toastTitle = 'Success!';
                        this.toastMessage = 'New Monthly Target record created';
                        this.toastVariant = 'success';
                        this.showToast();
                        console.log('wiredResults: ' + this.wiredMonthResult);
                        let thisResults = this.showProps(this.wiredMonthResult);
                        console.log('Create: ' + thisResults);
                        let thisResultsData = this.showProps(this.wiredMonthResult.data);
                        console.log('Create data: ' + thisResultsData);
                        let thisResultsError = this.showProps(this.wiredMonthResult.error);
                        console.log('Create error: ' + thisResultsError);
                        return refreshApex(this.wiredMonthResult);
                    })
                    .catch(error => {
                        this.error = error;
                        this.toastTitle = 'Error';
                        this.toastMessage = 'Unable to save the record: ' + error;
                        this.toastVariant = 'error';
                        this.showToast();
                    });
                break;