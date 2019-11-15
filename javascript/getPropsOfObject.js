showProps(obj){
    let result = '';
    for (const i in obj) {
        if (obj.hasOwnProperty(i)){
            result += i + ': ' + obj[i] + ' | ';
        }
    }
    return result;
}