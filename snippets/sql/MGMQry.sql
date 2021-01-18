SELECT DISTINCT
    j.EmailID,
    s.SubscriberKey,
    s.EVENTDATE as SENTDATE,
    o.EVENTDATE as OPENDATE,
    j.JOBID
FROM
    [_Job] j WITH (NOLOCK)
    INNER JOIN [_Sent] s WITH (NOLOCK)
        ON  j.JobID = s.JobID
    INNER JOIN [_Open] o WITH (NOLOCK)
        ON  s.jobID = o.jobID AND
            s.ListID = o.ListID AND
            s.BatchID = o.BatchID AND
            s.SubscriberID = o.SubscriberID
    LEFT JOIN [_Click] c WITH (NOLOCK)
        ON  o.jobID = c.jobID AND
            o.ListID = c.ListID AND
            o.BatchID = c.BatchID AND
            o.SubscriberID = c.SubscriberID
WHERE
    c.JobID IS NULL
AND (j.EmailName = 'MGM Email_Active' 
    OR j.EmailName = 'MGM Email_Donors' 
    OR j.EmailName = 'MGM_ACTIVE_12for12_2018 ' 
    OR j.EmailName = 'MGM_DONOR_12for12_2018 ')
AND s.EVENTDATE >= DATEADD(MONTH, -3, GETDATE())