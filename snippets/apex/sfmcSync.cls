List<Account> accnts = new List<Account>();

Account tomFPP = new Account(
	FirstName = 'Tom (Web Lead FPP Bulk)',
    LastName = 'Gough',
    PersonLeadSource = 'Website',
    Source_Product__c = 'FPP',
    PersonEmail = 'tgough@gldlife.com');

accnts.add(tomFPP);

Account tomOFP = new Account(
	FirstName = 'Tom (Web Lead OFP Bulk)',
    LastName = 'Gough',
    PersonLeadSource = 'Website',
    Source_Product__c = 'OFP',
    PersonEmail = 'tgough@gldlife.com');

accnts.add(tomOFP);

Account ellFPP = new Account(
	FirstName = 'Elliot (Web Lead FPP Bulk)',
    LastName = 'Singfield',
    PersonLeadSource = 'Website',
    Source_Product__c = 'FPP',
    PersonEmail = 'esingfield@gldlife.com');

accnts.add(ellFPP);

Account ellOFP = new Account(
	FirstName = 'Elliot (Web Lead OFP Bulk)',
    LastName = 'Singfield',
    PersonLeadSource = 'Website',
    Source_Product__c = 'OFP',
    PersonEmail = 'esingfield@gldlife.com');

accnts.add(ellOFP);

insert accnts;

List<Account> accUpdates = [SELECT Id, Sync_To_Marketing_Cloud__pc, Name FROM Account WHERE CreatedBy.Name = 'Eleanor Matthewman' AND CreatedDate >= 2020-10-20T00:00:00Z];
system.debug(accUpdates.size());

List<Account> accs = new List<Account>();
for(Account acc:accUpdates){
    acc.Sync_To_Marketing_Cloud__pc = true;
    accs.add(acc);
}
update accs;