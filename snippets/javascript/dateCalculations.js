validatePaymentDate(){
    let dateValid = true;
    let customError;
    let firstPaymentDate = new Date(this.newPayor.First_Payment_Date__c);
    let daysBetween = this.getDatesCount(new Date(), firstPaymentDate);
    if(daysBetween[0] < 0){
        customError = 'Payment date can\'t be in the past!';
        dateValid = false;
    }
    if(this.paymentFrequency === 'Monthly'){
        if(daysBetween[0] > 30){
            customError='Payment Date cannot be more than 30 days from today for monthly frequency.';
            dateValid = false;
        }
        else if(firstPaymentDate.getDate() > 28){
            customError='Payment Date has to be within 28th day of each month for monthly frequency.';
            dateValid = false;
        }
    }
    else if(this.paymentFrequency === '4-Weekly'){
        if(daysBetween[0] > 28){
            customError='Payment Date cannot be more than 28 days from today for 4-weekly frequency.';
            dateValid = false;
        }
        else if(firstPaymentDate.getDay() === 6 || firstPaymentDate.getDay() === 0){
            customError='Payment Date has to be a weekday for 4-weekly frequency.';
            dateValid = false;
        }
    }
    if(daysBetween[1] <= 5 && daysBetween[0] >= 0){
        customError='Because the date selected is less that 5 business days from today, the first payment may be delayed while Direct Debit is set up. The second and subsequent payments will be taken on the day requested.';
    }
    const dateCmp = this.template.querySelector("[data-id='paymentDate']");
    if(customError){
        dateCmp.setCustomValidity(customError);
    }
    else{
        dateCmp.setCustomValidity("");
    }
    dateCmp.reportValidity();
    this.paymentDateValid = dateValid;
}
getDatesCount(startDate, endDate) {
    startDate.setHours(0,0,0,0);

    if (endDate<startDate) {
        return [-1, -1];
     }
    let count = 0;
    let businessCount = 0;
    let loopDate = startDate;
    while (loopDate < endDate) {
        let dayOfWeek = loopDate.getDay();
        if (!((dayOfWeek === 6) || (dayOfWeek === 0))) {
            businessCount++;
        }
        count++;
        loopDate.setDate(loopDate.getDate() + 1);
    }
    return [count, businessCount];
}
get minDate(){
    return new Date();
}
get maxDate(){
    const today = new Date();
    if(this.paymentFrequency === "Monthly"){
        return today.setDate(today.getDate() + 30);
    }
    else{
        return today.setDate(today.getDate() + 28);
    }
}