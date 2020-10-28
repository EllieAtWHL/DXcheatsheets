            const quoteList = this.template.querySelectorAll('c-quote-line-form');
            console.log('quotelines: ' + JSON.stringify(this.quoteLines));
            console.log('Quoteline components: ' + JSON.stringify(quoteList));
            const refresh = new CustomEvent('refresh');
            for (let i = 0; i<quoteList.length;i++){
                console.log('Cycling child components: '+i);
                quoteList[i].quoteChange(refresh);
                quoteList[i].checkingLock();
            }