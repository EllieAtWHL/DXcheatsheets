***** Priority *****

IF({!department} = 'SOS', 
   CASE({!urgencyValueSOS},
                'Emergency', 25,
                'High', 9,
                'Low', 3,
                0),
CASE ({!importanceValueIT},
'Could Have', 1,
'Should Have', 3,
'Must Have', 5,
0)

*

CASE ({!urgencyValueIT},
'Low', 1,
'Medium', 2,
'High', 3,
'Urgent', 4,
'Emergency', 5,
0)
)

***** Urgency *****

IF({!typeCase} = 'SOS',
    CASE({!urgencyValueSOS},
        'Low', 'Could Have',
        'High', ' Should Have',
        'Emergency', 'Must Have',
        ''),
    {!importanceValueIT})

    ***** Importnance *****

    IF({!departmentValue} = 'IT",
    {!importanceValueIT},
    CASE({!urgencyValueSOS},
            'Low', 'Could Have',
            'High', 'Should Have',
            'Emergency', 'Must Have',
            '')
)