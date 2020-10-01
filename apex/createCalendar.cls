/********************************************* */

/*
Group userGroup = [SELECT Id FROM Group 
                   WHERE Name = 'Sales Group' 
                   LIMIT 1]; 
List<Id> groupId = new List<Id>(); 
groupId.add(userGroup.id); 
List<GroupMember> groupMembers = [SELECT UserOrGroupId 
                                  FROM GroupMember 
                                  WHERE GroupId IN: groupId]; 
List<CalendarView> calendarViews = new List<CalendarView>(); 
for (GroupMember groupMember : groupMembers) { 
    CalendarView calendarView = new CalendarView(name = 'Opportunity Close Dates', 
                                                 SobjectType = 'Opportunity', 
                                                 StartField = 'CloseDate', 
                                                 DisplayField = 'Name', 
                                                 OwnerId = groupMember.UserOrGroupId); 
    calendarViews.add(calendarView); 
} 
insert calendarViews; */

CalendarView cv = new CalendarView(Name = 'Annual Leave',
                                  sObjectType = 'Timesheet__c',
                                  StartField = 'Date__c',
                                  DisplayField = 'Agent_Name__c',
                                  OwnerId = '0050Y000004Es3tQAC',  //this is the Id of the person we want to share the calendar with
                                  ListViewFilterId = '00B1w000001LRdXEAW', //this is the Id of the list view, need to check it matches Prod
                                  Color = '9D307E');
insert cv;

/// or we could add in bulk

String groupName = 'Marketing_Operations';

Group userGroup = [SELECT Id FROM Group 
                   WHERE Name = :groupName 
                   LIMIT 1]; 
List<Id> groupId = new List<Id>(); 
groupId.add(userGroup.id); 
List<GroupMember> groupMembers = [SELECT UserOrGroupId 
                                  FROM GroupMember 
                                  WHERE GroupId IN: groupId]; 

List<CalendarView> calendarViews = new List<CalendarView>(); 
for (GroupMember groupMember : groupMembers) { 
    CalendarView cv = new CalendarView(Name = 'Annual Leave',
                                  sObjectType = 'Timesheet__c',
                                  StartField = 'Date__c',
                                  DisplayField = 'Agent_Name__c',
                                  OwnerId = groupMember.UserOrGroupId,  //this is the Id of the person we want to share the calendar with
                                  ListViewFilterId = '00B1w000001LRdXEAW', //this is the Id of the list view, need to check it matches Prod
                                  Color = '9D307E');
                                  calenderViews.add(cv);
}
insert calendarViews;