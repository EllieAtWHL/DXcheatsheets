IF(MONTH(TODAY())>MONTH( Birthdate__c ),
    YEAR(TODAY())-YEAR(Birthdate__c),
    IF(AND(MONTH(TODAY())=MONTH(Birthdate__c),
        DAY(TODAY())>=DAY(Birthdate__c)),
        YEAR(TODAY())-YEAR(Birthdate__c),
        (YEAR(TODAY())-YEAR(Birthdate__c))-1))

if(todayMonth > month){
    age = todayYear-year;
}else if(todayMonth === month && todayDay >= day){
    age = todayYear-year;
}else{
    age = (todayYear-year)-1
}