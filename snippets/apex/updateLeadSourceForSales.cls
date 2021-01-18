List<Lead> leads = [SELECT Id, Name, Entry_URL__c, ConvertedAccount.PersonLeadSource, ConvertedAccount.Sub_Source__c, ConvertedAccount.Sub_Source_2__c FROM Lead WHERE Id in ('00Q1n00000P3GhuEAF')];
Map<Id,String> emailNames = new Map<Id,String>();
Map<Id, Account> mapAccs = new Map<Id, Account>();
List<Account> accs= new List<Account>();
SET<Id> keys = mapAccs.keyset();
for (Lead l:leads){
    System.PageReference pageReference = new System.PageReference(l.Entry_URL__c);
    Map<String,String> parameters = pageReference.getParameters();
    emailNames.put(l.ConvertedAccountId, parameters.get('utm_campaign')) ;   
    mapAccs.put(l.ConvertedAccountId,l.ConvertedAccount);
    accs.add(l.ConvertedAccount);
}
system.debug(mapAccs);
system.debug(emailNames);

List<Prospect_Activity__c> sales = [SELECT Id, Lead_Source__c, Sub_Source__c, Sub_Source_2__c, Prospect__c FROM Prospect_Activity__c WHERE RecordType.Name = 'Sale' and Prospect__c in :keys];
system.debug(sales);

for(Account acc : accs){
    acc.PersonLeadSource = 'Email';
    acc.Sub_Source__c = 'Web Sale';
    acc.Sub_Source_2__c = emailNames.get(acc.Id).substring(0,49);
}
for(Prospect_Activity__c pa : sales){
    pa.Lead_Source__c = 'Email';
    pa.Sub_Source__c = 'Web Sale';
    pa.Sub_Source_2__c = emailNames.get(pa.Prospect__c).substring(0,49);
}
system.debug(accs);
system.debug(sales);
update accs;
update sales;
