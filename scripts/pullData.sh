#!/usr/bin/env bash

while [ ! -n "$ALIAS"  ]
do
  echo "Please enter the alias to retrieve from:"
  read ALIAS -r
done

echo 'Retrieving Premiums'
RES= "sfdx force:data:soql:query -u ${ALIAS} -q 'SELECT Age__c, M_12_Level__c, M_12_Step__c, M_24_Level__c, M_24_Step__c, S_12_Level__c, S_12_Step__c, S_24_Level__c, S_24_Step__c FROM Premium__c' -r csv > data/premium.csv"
echo $RES
if [ "$?" = "1" ]
then
  echo "Error retrieving Premium data"
  exit
fi

echo 'Retrieving Occupations'
sfdx force:data:soql:query -u ${ALIAS} -q "SELECT Name, Code__c FROM Occupation__c" -r csv > data/occupation.csv
if [ "$?" = "1" ]
then
  echo "Error retrieving Occupation data"
  exit
fi

echo 'Loading Premiums'
sfdx force:data:bulk:upsert -f data/premium.csv -i Id -s Premium__c -w 100
if [ "$?" = "1" ]
then
  echo "Error loading Premium data"
  exit
fi

echo 'Loading Occupations'
sfdx force:data:bulk:upsert -f data/occupation.csv -i Name -s Occupation__c -w 100
if [ "$?" = "1" ]
then
  echo "Error loading Occupation data"
  exit
fi

### this retrieves the lead source config, but we cannot load them at the moment due to SOQL queries in triggers
### sfdx force:data:soql:query -u prod -q "SELECT Active_Date__c, End_Date__c, CXP_DDI__c, TFN__c,  Source_Product__c, Lead_Source__c,Dialer_List__c,   Sub_Source__c,Coupon_Code__c, Sales_Incentive__c, NN_DDI__C, NN_Group_Master__c FROM Lead_Source_Config__c WHERE Active__c = true" -r csv > data/leadSourceConfig.csv