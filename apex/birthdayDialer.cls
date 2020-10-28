List<Account> birthdayAccounts = [
    SELECT Id, Dialer_List__c 
    FROM Account
    WHERE 
    Lead_Lifecycle_stage__c IN ('315 - Birthday Dialer', 
        '325 - Birthday Dialer', 
        '335 - Birthday Dialer', 
        '345 - Birthday Dialer', 
        '355 - Birthday Dialer')];
List<Account> updateAccs = new List<Account>();
for(Account acc : birthdayAccounts){
    acc.Dialer_Site__c = 'Glasgow';
    updateAccs.add(acc);
}
update updateAccs;