SELECT 
    x.SubscriberKey, 
    x.SendDate, 
    x.EmailName, 
    x.JobId
FROM 
    (SELECT  
        o.SubscriberKey, 
        o.SendDate, 
        o.EmailName, 
        o.JobId, 
        ROW_NUMBER() OVER(PARTITION BY o.SubscriberKey ORDER BY o.SendDate) AS RowNumber
    FROM [MGM_Open] o
    LEFT JOIN [MGM_Click] c ON o.SubscriberKey = c.SubscriberKey
    WHERE c.SubscriberKey IS NULL
    ) x
WHERE x.RowNumber = 1