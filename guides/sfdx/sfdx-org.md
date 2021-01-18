Assign DevHub org
    sfdx force:auth:web:login -d -a DevHub

Assign a Default Org
    sfdx force:auth:web:login -a codeOrg -s

Assign a sandbox org
    sfdx force:auth:web:login -r https://test.salesforce.com -a <FullSandbox>

Set an existing scratch org as default
    sfdx force:config:set defaultusername=<username>

Set an existing org as default devhub
    sfdx force:config:set defaultdevhubusername=<username>

Show list of orgs
    sfdx force:org:list

Create a project
    sfdx force:project:create --projectname <mywork>

Create a scratch org
    sfdx force:org:create -a <aliasname> -f project-scratch-def.json -s (sets as default org for project)
    sfdx force:org:create -a testDeploy -f config/EconScratchOrgDef.json -s

Delete a scratch org
    sfdx force:org:delete -u DXSpike

Check org limits
    sfdx force:limits:api:display -u DevHub