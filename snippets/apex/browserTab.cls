    /* both of these methods conducts a check before closing/refreshing a browser
        what I wanted was closing a Salesforce tab

    beforeUnloadHandler(ev) {
        console.log("beforeUnloadHandler called");
        return 'Are you sure?';
    }
    connectedCallback() {
        window.addEventListener("beforeunload", this.beforeUnloadHandler);
        console.log("connectedCallback executed");
    }
    disconnectedCallback() {
        window.removeEventListener("beforeunload", this.beforeUnloadHandler);
        console.log("disconnectedCallback executed");
        return 'Are you sure?';
    }
     */