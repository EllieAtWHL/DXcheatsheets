    //helper to easily increment the days
    incrementDate(dateInput,increment) {
        let dateFormatToTime = new Date(dateInput);
        return new Date(dateFormatToTime.getTime() + (increment * 86400000));
    }

    incrementMonth(dateInput, increment){
        let dateCheck = dateInput.getDate();
        dateInput.setMonth(dateInput.getMonth() + +increment);
        if (dateInput.getDate() != dateCheck){
            dateInput.setDate(0);
        }
        return dateInput;
    }