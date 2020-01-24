

if (this.paymentFrequencySelected === 'Monthly') {
    this.API = (rs[1] * 12).toFixed(2);
}
else { 
    this.API = (rs[1] * 13).toFixed(2);
}

this.weekly = ((this.API/ 12).toFixed(2)) / (52 / 12);
if (this.paymentFrequencySelected !== 'Monthly') {
    pweekly = ((pannual / 13).toFixed(2)) / 4;}
this.weekly = this.weekly.toFixed(2); 