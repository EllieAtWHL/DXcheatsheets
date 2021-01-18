SELECT 
    mc.uid, 
    mc.email, 
    mc.first_name, 
    mc.last_name, 
    mc.country, 
    mc.region, 
    mc.region_cd, 
    mc.country_cd, 
    mc.[accept_mail_from_dotcom], 
    mc.[accept_mail_from_group], 
    mc.[accept_mail_from_eiu], 
    mc.engaged, 
    mc.subscriber, 
    mc.newsletters_editors_picks, 
    mc.newsletters_daily_dispatch, 
    mc.newsletters_espresso_eu, 
    mc.newsletters_espresso_us, 
    mc.newsletters_espresso_asia, 
    mc.print_subscriber, 
    mc.digital_subscriber, 
    mc.is_active, 
    mc.migrated
FROM [Daily_Dispatch_customer_DE_95%_Control]  c
    INNER JOIN Master_Customer AS mc WITH (NOLOCK) ON mc.email = c.email
    LEFT JOIN [Daily_Dispatch_customer_DE_20_Test] ex ON dd.email = ex.email
WHERE mc.newsletters_daily_dispatch = 1 
    AND ex.email is NULL