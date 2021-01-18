create or replace view vw_sf_timesheet AS

    SELECT

        sft.id as timesheet_id,
        sft.namex as timesheet_name,
        sf_agent.namex as agent_name,
        sft.createddate,
        sf_created.namex as createdby_user,
        sft.lastmodifieddate,
        sf_lastmod.namex as lastmodifiedby_user,
        date(sft.date__c) as timesheet_date,
        difference__c as difference,
        hours_expected__c as hours_expected,
        hours_worked__c as hours_worked,
        reason__c as reason,
        sft.team__c as timesheet_team,
        sf_agent.team__c as agent_team,
        sf_agent.employeenumber as employeenumber,
        sf_agent.employee_start_date__c as employee_startdate,
        sf_agent.employee_end_date__c as employee_endate,
        sf_agent.isactive as isactive,
        sf_agent.shift_pattern__c as agent_shiftpattern

    FROM sf_timesheet__c sft JOIN sf_user sf_agent ON sft.agent__c=sf_agent.id
        JOIN sf_user sf_created ON sft.createdbyid=sf_created.id
        JOIN sf_user sf_lastmod ON sft.lastmodifiedbyid=sf_lastmod.id

    WHERE sft.delete_flag != 'Y'

grant select on table vw_sf_prospect to opsupport