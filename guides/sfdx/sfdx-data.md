Export data from an environment
- `sfdx force:data:tree:export -q 'SELECT Name, X1843_Edition__c, CurrencyIsoCode, Display_Tax__c, Economist_Edition__c, Espresso_Edition__c, Global_Region__c, isAvailable__c, ISO_Country_Code__c, ISO_Country_Name__c, Price_Zone__c, Region__c, Sub_Region__c, World_In_Edition__c FROM Country__c LIMIT 150' -d data/core/country1 -u CASEQA --plan`

Import data to a scratch org/sandbox from json
- `sfdx force:data:tree:import -u cleanUp --plan data/core/country1/Country__c-plan.json`

Import bulk data to scratch org/sandbox from csv
- `sfdx force:data:bulk:upsert -s Global_Price_Tiers__c -f data/core/globalPriceTiers/listGlobalPriceTiers.csv -w 100 -i Name`
- `sfdx force:data:bulk:upsert -s Country__c -f data/country/extractCountries.csv -w 100 -i Name -u eiucom`