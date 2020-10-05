IF(Comms_Criteria_Is_Unrenewed_Donee__c  = TRUE,
	"Unrenewed Donee",
	IF(AND(Publication__c = "The Economist",ISPICKVAL(Account.Marketing_Segment_TheEconomist__c, "Direct Ren")),
        CASE(IF(Subscription_term_number__c = 1, "A",
                    IF(Subscription_term_number__c = 2, "B","C")),

                    'A', "Direct Ren1",
                    'B', "Direct Ren2",
                    'C', "Direct Ren3+",
             NULL
            ),
    IF(Publication__c = "The Economist", TEXT(Account.Marketing_Segment_TheEconomist__c),
       IF(
            AND(
                OR(
                    Publication__c = "1843",
                    Publication__c = "Intelligent Live"
                    ),
                ISPICKVAL(Account.Marketing_Segment_1843__c, "Direct Ren")),
               CASE(IF(Subscription_term_number__c = 1, 'A',
                    IF(Subscription_term_number__c = 2, 'B','C')),

                    'A', "Direct Ren1",
                    'B', "Direct Ren2",
                    'C', "Direct Ren3+",
                    NULL
                   ),
            TEXT(Account.Marketing_Segment_1843__c)
          )
        )
))