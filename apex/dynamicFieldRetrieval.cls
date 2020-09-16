public class lwc_timesheet {

	@AuraEnabled(cacheable=true)
	public static List<Timesheet__c> getSheets(string team, String period){

		Date today = Date.today();

		if(period == 'week'){
			Date dayOfWeekCalc = Date.newInstance(0001,1,1);
			Integer dayOfToday = Math.mod(dayOfWeekCalc.daysBetween(today), 7);
			Date weekStart = today.addDays(- dayOfToday);
			Date weekEnd = weekStart.addDays(6);
		}

		String query = 'SELECT Id, Agent__r.Name, Date__c, Hours_Worked__c, Hours_Expected__c, Reason__c FROM Timesheet__c WHERE ';

		if(team != NULL){
			query += 'Team__c = :team AND ';
		}

		if(period == 'day'){
			query += 'Date__c = :today ';
		}

		if(period == 'week'){
			query += 'Date__c >= :weekStart AND Date__c <= :weekEnd ';
		}

		query += 'ORDER BY Agent__r.Name, Date__c';


		system.debug('Query: ' + query);

		return database.query(query);
	}


	@AuraEnabled
	public static void refreshSheets(String team){

		Date today = Date.today();
		Date dayOfWeekCalc = Date.newInstance(0001,1,1);
		Integer dayOfToday = Math.mod(dayOfWeekCalc.daysBetween(today), 7);
		Date weekStart = today.addDays(- dayOfToday);
		Date weekEnd = weekStart.addDays(6);

		List<Timesheet__c> existingTimesheets = [SELECT Id, Agent__r.Name, Date__c, Hours_Worked__c, Hours_Expected__c, Reason__c FROM Timesheet__c WHERE Team__c = :team AND Date__c >= :weekStart AND Date__c <= :weekEnd ORDER BY Agent__r.Name, Date__c];
		List<Timesheet__c> createTimesheets = new List<Timesheet__c>();
		List<User> agents = [SELECT Id, Name, Shift_Pattern__c FROM User WHERE Team__c = :team and IsActive = TRUE AND Profile.Name='Agent'];

		Date sheetDate = NULL;

		 Map<String, Timesheet> mapExistingSheets = new Map<String, Timesheet>();
		 for(Timesheet__c sheet:existingTimesheets){
			 Timesheet objSheet = new Timesheet();
			 objSheet.concatUserDate = sheet.Agent__c + String.valueof(sheet.Date__c);
			 objSheet.userId = sheet.Agent__c;
			 objSheet.timesheetDate = sheet.Date__c;
			 mapExistingSheets.put(objSheet.concatUserDate, objSheet);
		 }

		for (User user:agents){
			for(Integer i = 0; i<7; i++){
				if(mapExistingSheets.containsKey(user.Id + String.valueOf(weekStart.addDays(i)))){
				} else {
					sheetDate = weekStart.addDays(i);
					Timesheet__c sheet = newTimesheet(team, user.Id, sheetDate, user.Shift_Pattern__c);
					if(sheet != NULL) {
						createTimesheets.add(sheet);
					}
				}
			}
		}
		insert createTimesheets;
	}

	public static Timesheet__c newTimesheet(String team, Id userID, Date sheetDate, String shiftPattern){

		Datetime dateConv = Datetime.newInstance(sheetDate.year(), sheetDate.month(), sheetDate.day());
		String day = dateConv.format('EEEE') + '__c';
		Shift_Pattern__mdt shiftPatternRec = [SELECT DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName, Saturday__c, Sunday__c, Monday__c, Tuesday__c, Wednesday__c, Thursday__c, Friday__c FROM Shift_Pattern__mdt WHERE Label = :shiftPattern];

		Map<String,Schema.SObjectField> shiftPatternDescribe = Shift_Pattern__mdt.sObjectType.getDescribe().fields.getMap();
		Map<String,Decimal> shiftPatternMap = new Map<String,Decimal>();
		for (Schema.SObjectField currentField: shiftPatternDescribe.Values()){
			if(String.valueof(currentField).right(3) == '__c'){
				String expectedString = String.valueof(shiftPatternRec.get(currentField));
				Decimal expected = Decimal.valueof(expectedString);
				system.debug('Current field: ' + currentField + ' | Value: ' + expectedString);
				shiftPatternMap.put(String.valueOf(currentField), expected);
			}
		}

		if(shiftPatternMap.get(day) > 0) {
			Timesheet__c sheet = new Timesheet__c(
					Agent__c = userId,
					Team__c = team,
					Date__c = sheetDate,
					Hours_Expected__c = shiftPatternMap.get(day));
			return sheet;
		}
		else {
			return NULL;
		}

	}

	@AuraEnabled
	public static void saveTimesheets(List<Timesheet__c> sheets){
		system.debug(sheets);
		update sheets;
	}

	public class Timesheet{
		@AuraEnabled
		public Id userId {get;set;}
		@AuraEnabled
		public Date timesheetDate {get;set;}
		@AuraEnabled
		public string concatUserDate {get;set;}
	}


}