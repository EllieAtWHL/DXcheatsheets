/* ****** CREATE TRACKING VIEWS FROM BASE TABLES BUT JOINING IN DATA FROM SEND ****** */

CREATE VIEW vw_rpt_sfmc_tracking_sent AS
    SELECT
        s."ClientID",
        s."SendID",
        s."SubscriberKey",
        s."EmailAddress",
        s."SubscriberID",
        s."ListID",
        CAST(s."EventDate" as DATE),
        s."EventType",
        s."BatchID",
        s."TriggeredSendExternalKey",
        j."Campaign",
        j."Product",
        j."JourneyEmailNumber",
        j."EmailCreativeNumber",
        j."EmailName"
    FROM sfmc_tracking_sent s
    INNER JOIN sfmc_tracking_send_jobs j ON s."TriggeredSendExternalKey"=j."TriggeredSendExternalKey";

CREATE VIEW vw_rpt_sfmc_tracking_bounces AS
    SELECT
        b."ClientID",
        b."SendID",
        b."SubscriberKey",
        b."EmailAddress",
        b."SubscriberID",
        b."ListID",
        CAST(b."EventDate" as DATE),
        b."EventType",
        b."BounceCategory",
        b."SMTPCode",
        b."BounceReason",
        b."BatchID",
        b."TriggeredSendExternalKey",
        j."Campaign",
        j."Product",
        j."JourneyEmailNumber",
        j."EmailCreativeNumber",
        j."EmailName"
    FROM sfmc_tracking_bounces b
    INNER JOIN sfmc_tracking_send_jobs j ON b."TriggeredSendExternalKey"=j."TriggeredSendExternalKey";

CREATE VIEW vw_rpt_sfmc_tracking_opens AS
    SELECT
        o."ClientID",
        o."SendID",
        o."SubscriberKey",
        o."EmailAddress",
        o."SubscriberID",
        o."ListID",
        CAST(o."EventDate" as DATE),
        o."EventType",
        o."BatchID",
        o."TriggeredSendExternalKey",
        CASE
            WHEN o."IsUnique" = 'True' THEN 1
            ELSE 0
        END AS IsUnique,
        j."Campaign",
        j."Product",
        j."JourneyEmailNumber",
        j."EmailCreativeNumber",
        j."EmailName"
    FROM sfmc_tracking_opens o
    INNER JOIN sfmc_tracking_send_jobs j ON o."TriggeredSendExternalKey"=j."TriggeredSendExternalKey";

CREATE VIEW vw_rpt_sfmc_tracking_clicks AS
    SELECT
        c."ClientID",
        c."SendID",
        c."SubscriberKey",
        c."EmailAddress",
        c."SubscriberID",
        c."ListID",
        CAST(c."EventDate" as DATE),
        c."EventType",
        c."SendURLID",
        c.urlid,
        c.url,
        c."Alias",
        c."BatchID",
        c."TriggeredSendExternalKey",
        CASE
            WHEN c."IsUnique" = 'True' THEN 1
            ELSE 0
        END AS "IsUnique",
       CASE
           WHEN c."IsUniqueForURL" = 'True' THEN 1
           ELSE 0
       END AS "IsUniqueForURL",
        j."Campaign",
        j."Product",
        j."JourneyEmailNumber",
        j."EmailCreativeNumber",
        j."EmailName"
    FROM sfmc_tracking_clicks c
    INNER JOIN sfmc_tracking_send_jobs j ON c."TriggeredSendExternalKey"=j."TriggeredSendExternalKey";

CREATE VIEW vw_rpt_sfmc_tracking_unsubs AS
    SELECT
        u."ClientID",
        u."SendID",
        u."SubscriberKey",
        u."EmailAddress",
        u."SubscriberID",
        u."ListID",
        CAST(u."EventDate" as DATE),
        u."EventType",
        u."BatchID",
        u."TriggeredSendExternalKey",
        u."UnsubReason",
        j."Campaign",
        j."Product",
        j."JourneyEmailNumber",
        j."EmailCreativeNumber",
        j."EmailName"
    FROM sfmc_tracking_unsubs u
    INNER JOIN sfmc_tracking_send_jobs j ON u."TriggeredSendExternalKey"=j."TriggeredSendExternalKey";

/* ****** Direct Email sales data ****** */
 CREATE OR REPLACE VIEW vw_rpt_sfmc_direct_sales AS
SELECT
        sfpa.activity_id,
        sfpa.activity_date,
        sfpa.lead_source,
        sfpa.sub_source,
        sfpa.sub_source_2,
        sfpa.total_api,
        sfpa.total_cover,
        sfpa.total_policies,
        fn_gross_sale_commission_total(sfpa.activity_id) AS total_commission,
        j."EmailCreativeNumber",
        j."Product",
        j."Campaign"
    FROM vw_mat_sf_prospect_activity sfpa
    LEFT JOIN (
        SELECT "EmailName", "EmailCreativeNumber","Product", "Campaign" FROM sfmc_tracking_send_jobs GROUP BY "EmailName", "EmailCreativeNumber", "Product", "Campaign"
        ) j ON sfpa.sub_source_2=j."EmailName"
    WHERE sfpa.activity_type = 'Sale'
    AND sfpa.lead_source = 'Email'
    AND sfpa.sub_source = 'Web Sale';



/* ****** Inbound call from Email data ****** */

CREATE OR REPLACE VIEW vw_rpt_sfmc_inbound_calls AS
    SELECT *
    FROM vw_master_leads_count
    WHERE lead_source = 'Email'
      AND sub_source='Inbound Call';

/* ****** Inbound sales data ****** */

 CREATE OR REPLACE VIEW vw_rpt_sfmc_inbound_sales AS
    SELECT
        sfpa.activity_id,
        sfpa.activity_date,
        sfpa.lead_source,
        sfpa.sub_source,
        sfpa.sub_source_2,
        sfpa.total_api,
        sfpa.total_cover,
        sfpa.total_policies,
        fn_gross_sale_commission_total(sfpa.activity_id) AS total_commission,
        sfpa.source_product
    FROM vw_mat_sf_prospect_activity sfpa
    WHERE sfpa.activity_type = 'Sale'
    AND sfpa.lead_source = 'Email'
    AND sfpa.sub_source = 'Inbound Call';

/* ****** "GOT A QUOTE" data ****** */

CREATE OR REPLACE VIEW vw_rpt_sfmc_website_quotes AS
    WITH base_query AS (
    SELECT id,
           createddate,
           entry_url__c,
           split_part(regexp_split_to_table((regexp_matches(entry_url__c, '\?(.*)'))[1], '&'), '=', 1) AS key,
           replace(split_part(regexp_split_to_table((regexp_matches(entry_url__c, '\?(.*)'))[1], '&'), '=', 2),'+',' ') AS value
    FROM sf_lead
    WHERE delete_flag!='Y'
      AND isconverted='false'
      AND entry_url__c IS NOT NULL
      AND can_t_call_reason__c='Duplicate from Email')
    SELECT bq.id,
           createddate,
           bq.entry_url__c,
           bq.value as email_name,
           j."EmailCreativeNumber",
           j."Product",
           j."Campaign"
    FROM base_query bq
    LEFT JOIN (
        SELECT "EmailName", "EmailCreativeNumber","Product", "Campaign" FROM sfmc_tracking_send_jobs GROUP BY "EmailName", "EmailCreativeNumber", "Product", "Campaign"
        ) j ON bq.value=j."EmailName"
    WHERE key = 'utm_campaign';
