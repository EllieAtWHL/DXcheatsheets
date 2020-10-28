
    handleLoad(event) {
        if (!this.loadedForm) {
            this.timesheetRecord.Id = this.recid;
            this.note.ParentId = this.recid;

            let fields = Object.values(event.detail.records)[0].fields;
            this.timesheetRecord = {
                Id: this.recid,
                ...Object.keys(fields)
                    .filter((field) => !!this.template.querySelector(`[data-field=${field}]`))
                    .reduce((total, field) => {
                        total[field] = fields[field].value;
                        return total;
                    }, {})
            };
            this.note.ParentId = this.recid;
            this.loadedForm = true;


        }
    } // handleLoad

