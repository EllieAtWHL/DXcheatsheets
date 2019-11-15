    //helper to easily increment the days
    incrementDate(dateInput,increment) {
        let dateFormatToTime = new Date(dateInput);
        return new Date(dateFormatToTime.getTime() + (increment * 86400000));
    }