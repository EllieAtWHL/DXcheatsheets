Lead newLead = new Lead(
	FirstName = 'Ellie',
	LastName = 'Matthewman',
	Entry_Url__c = 'https://promislife.co.uk/?sfid=0031w00000i9uC2AAI&utm_campaign=Testing+Subscriber+Key+in+Link&utm_medium=email&utm_source=',
	Phone = '07710237426',
	LeadSource = 'Website' );
insert newLead;

String urlLink = URL.getOrgDomainUrl().toExternalForm() + '/';
system.debug('Domain: ' + urlLink);
urlLink = URL.getSalesforceBaseUrl().toExternalForm() + '/';
system.debug('Base: ' + urlLink);

System.PageReference pageReference = new System.PageReference(newLead.Entry_URL__c);
Map<String,String> parameters = pageReference.getParameters();
String sfid = parameters.get('sfid');