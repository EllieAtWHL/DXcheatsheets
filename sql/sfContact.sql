SELECT
    sfdc.Id as SubscriberKey,
    sfdc.Email as EmailAddress,
    CASE
        WHEN allsub.Status = 'unsubscribed' THEN 'active'
        ELSE allsub.Status
    END as Status
FROM
    Contact_Salesforce as sfdc
RIGHT JOIN
    _subscribers as allsub
ON sfdc.Id = allsub.SubscriberKey
WHERE sfdc.Resubscribe__c = TRUE