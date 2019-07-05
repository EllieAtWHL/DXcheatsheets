Push source  code into scratch org
    sfdx force:source:push

Pull data from source org into project
    sfdx force:source:pull

Convert code repo to DX friendly code
    sfdx force:mdapi:convert -r <rootFolder>

Convert DX code into deployable metadata
    sfdx force:source:convert -d <casesaleforce>

Deploy metadata into org
    sfdx force:mdapi:deploy -d <mdapioutput/> -u <MyTP> -w 100 -l RunLocalTests

Destructive changes
    sfdx force:mdapi:deploy -d <destruct> -u <CITest> -w -1

Install a Package
    sfdx force:package:install --package <packageId>

Retrieve Unmanaged Package
    sfdx force:mdapi:retrieve -s -r ./mdapipkg -u <username> -p <package name>

Retrieve metadata from untracked Org
    Components from package.xml
        sfdx force:source:retrieve -x path/to/package.xml
    All Apex Classes
        sfdx force:source:retrieve -m ApexClass
    A specific apex class
        sfdx force:source:retrieve -m ApexClass:MyApexClass
