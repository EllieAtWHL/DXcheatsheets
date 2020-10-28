public class getWeeklyRecords {

    public static void getWeeklyRecords() {

    Date dayOfWeekCalc = Date.newInstance(0001,1,1);
            Date today = Date.today();
            Integer dayOfToday = Math.mod(dayOfWeekCalc.daysBetween(today), 7);
            Date weekStart = today.addDays(- dayOfToday);
            Date weekEnd = weekStart.addDays(6);

            List<Custom_Object__c> days = [SELECT Id, Date__c  FROM Custom_Object__c
										WHERE Date__c >= :weekStart AND Date__c <= :weekEnd
										ORDER BY Date__c ASC];
            
    }
}