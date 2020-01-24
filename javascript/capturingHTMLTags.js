        const dateCmp = this.template.querySelector("[data-id='paymentDate']");
        console.log('date comp: ' + JSON.stringify(dateCmp));
        if(customError){
            dateCmp.setCustomValidity(customError);
        }
        else{
            dateCmp.setCustomValidity("");
        }