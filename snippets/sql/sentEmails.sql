SELECT j.EmailName, 
    s.EmailAddress 
FROM _Job j 
    INNER JOIN _Sent se ON j.JobID = se.JobID 
    INNER JOIN _Subscribers s ON se.SubscriberKey = s.SubscriberKey 
WHERE se.EventDate < GetDate() 
    AND s.EmailAddress = "marklewis8085@aol.com"