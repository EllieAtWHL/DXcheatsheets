SELECT 
    x.SubscriberKey,
    x.JobID,
    x.BatchID,
    x.SendDate,
    x.EmailName,
    x.EmailID,
    x.EMAIL_ADDRESS,
    x.RowNumber, 
    x.SALUTATION,
    x.Country
FROM
    (SELECT 
        s.SubscriberKey,
        s.JobID,
        s.BatchID,
        convert(char(19),s.EventDate,20) as SendDate,
        j.EmailName,
        j.EmailID,
        mgd.EMAIL_ADDRESS,
        ROW_NUMBER() OVER(PARTITION BY mgd.EMAIL_ADDRESS ORDER BY mgd.EMAIL_ADDRESS) AS RowNumber,
        mgd.SALUTATION,
        mgd.Country
    FROM _Sent s
    WHERE s.EventDate > dateadd(d,-70,getdate())
    ) x
WHERE x.RowNumber = 1