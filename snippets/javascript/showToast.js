    //use to display an appropriate toast
    showToast() {
        const event = new ShowToastEvent({
            title: this.toastTitle,
            message: this.toastMessage,
            variant: this.toastVariant,
        });
        this.dispatchEvent(event);
    }