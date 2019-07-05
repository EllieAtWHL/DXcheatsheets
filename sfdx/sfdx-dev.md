Create an apex class
    sfdx force:apex:class:create -n <AccountController> -d force-app/main/default/classes

Create a lightning component
    sfdx force:lightning:component:create -n <AccountLocator> -d force-app/main/default/aura

Execute anon apex
    sfdx force:apex:execute -f apex/createAccEnt.apex -u data

Run apex tests
    sfdx force:apex:test:run -c -r human -d apex_tests