SELECT 
    x.SubscriberKey
    ,x.JobID
    ,x.BatchID,
    x.SendDate
    ,x.EmailName
    ,x.EmailID
    ,x.EMAIL_ADDRESS
    ,x.RowNumber
    ,x.SALUTATION
    ,x.Country
FROM
    (
    SELECT 
        s.SubscriberKey
        ,s.JobID
        ,s.BatchID,
        convert(char(19),s.EventDate,20) as SendDate
        ,j.EmailName
        ,j.EmailID
        ,mgd.EMAIL_ADDRESS
        ,ROW_NUMBER() OVER(PARTITION BY mgd.EMAIL_ADDRESS ORDER BY mgd.EMAIL_ADDRESS) AS RowNumber
        ,mgd.SALUTATION
        ,mgd.Country
    FROM _Sent s
        left join MGM_DONORS_MASTER mgd on s.SubscriberKey = mgd.EMAIL_ADDRESS
        left join _Open o with (NOLOCK)
        on s.JobID = o.JobID and s.ListID = o.ListID and s.BatchID = o.BatchID and s.SubscriberID = o.SubscriberID and o.IsUnique = 1
        left join _Click c with (NOLOCK)
        on s.JobID = c.JobID and s.ListID = c.ListID and s.BatchID = c.BatchID and s.SubscriberID = c.SubscriberID and c.IsUnique = 1
        left join _Job j with (NOLOCK)
        on s.JobID = j.JobID
    WHERE s.EventDate > dateadd(d,-70,getdate())
        AND j.JobID in ('100027','103572','103574','103577','105979','100027','100026','100028','100024','105979','100029')
        AND (o.SubscriberID is NULL and c.SubscriberID is NULL)
        ) x
WHERE x.RowNumber = 1