trigger AutoConvert on Lead (after update) {
	list<Lead> LeadsToConvert = new list<Lead>();
	for(Lead myLead: Trigger.new){
		if(!myLead.isConverted)
			LeadsToConvert.add(myLead);
	}

	list<Database.LeadConvert> leadConverts = new list<Database.LeadConvert>();
	for(Lead myLead : LeadsToConvert){
		Database.LeadConvert lc = new database.LeadConvert();
		lc.setLeadId(myLead.Id);
		lc.convertedStatus = 'Qualified';
		//Database.ConvertLead(lc,true);
		lc.setDoNotCreateOpportunity(true);
		leadConverts.add(lc);
	}

	if(!leadConverts.isEmpty()){
		for(Integer i = 0; i <= leadConverts.size()/100 ; i++){
			list<Database.LeadConvert> tempList = new list<Database.LeadConvert>();
			Integer startIndex = i*100;
			Integer endIndex = ((startIndex+100) < leadConverts.size()) ? startIndex+100: leadConverts.size();
			for(Integer j=startIndex;j<endIndex;j++){
				tempList.add(leadConverts[j]);
			}
			Database.LeadConvertResult[] lcrList = Database.convertLead(tempList, false);
			for(Database.LeadConvertResult lcr : lcrList)
				System.assert(lcr.isSuccess());
		}
	}
}