const quoteList = this.template.querySelectorAll('c-quote-line-form');
            for (let i = 0; i<quoteList.length;i++){
                quoteList[i].refreshQuoteLines();
            }