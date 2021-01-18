/*
    *** CREATE VIEWS FROM BASE TABLES ***
 */

CREATE VIEW vw_sfmc_tracking_sent AS
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
        CAST(j."JourneyEmailNumber" as TEXT)
    FROM sfmc_tracking_sent s
    INNER JOIN sfmc_tracking_send_jobs j ON "TriggeredSendExternalKey"="TriggerSendExternalKey";

CREATE VIEW vw_sfmc_tracking_bounces AS
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
        j."JourneyEmailNumber"
    FROM sfmc_tracking_bounces b
    INNER JOIN sfmc_tracking_send_jobs j ON "TriggeredSendExternalKey"="TriggerSendExternalKey";

CREATE VIEW vw_sfmc_tracking_opens AS
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
        j."JourneyEmailNumber"
    FROM sfmc_tracking_opens o
    INNER JOIN sfmc_tracking_send_jobs j ON "TriggeredSendExternalKey"="TriggerSendExternalKey";

CREATE VIEW vw_sfmc_tracking_clicks AS
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
        j."JourneyEmailNumber"
    FROM sfmc_tracking_clicks c
    INNER JOIN sfmc_tracking_send_jobs j ON "TriggeredSendExternalKey"="TriggerSendExternalKey";

CREATE VIEW vw_sfmc_tracking_unsubs AS
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
        j."JourneyEmailNumber"
    FROM sfmc_tracking_unsubs u
    INNER JOIN sfmc_tracking_send_jobs j ON "TriggeredSendExternalKey"="TriggerSendExternalKey";

/*
    *** INSERT SENT FROM STAGING TO BASE TABLE ***
 */

 INSERT INTO sfmc_tracking_sent
    SELECT * FROM sfmc_staging_sent;