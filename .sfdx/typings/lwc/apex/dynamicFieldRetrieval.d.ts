declare module "@salesforce/apex/lwc_timesheet.getSheets" {
  export default function getSheets(param: {team: any, period: any}): Promise<any>;
}
declare module "@salesforce/apex/lwc_timesheet.refreshSheets" {
  export default function refreshSheets(param: {team: any}): Promise<any>;
}
declare module "@salesforce/apex/lwc_timesheet.saveTimesheets" {
  export default function saveTimesheets(param: {sheets: any}): Promise<any>;
}
