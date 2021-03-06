It would be nice for this to be something in the actual CLI commands: the ability to clean up old orgs that are no longer needed.

For the time being, you need to manually cleanup the DX configs in the local installation.

On mac/linux, you can find your DX config folder, called .sfdx in your user home directory.

`cd ~/.sfdx`

On windows, you can use `%USERPROFILE%\.sfdx`

In that folder there are a host of .json files, named for the username of the admin user you registered for that org. In my case, in this instance it was called peter@dx.pilot, so sure enough, there it was:

`peter@dx.pilot.json`

Inside the file, or the hashes for current access token, refresh token, and all the other OAuth goodness that allows DX to access your org. So I simply deleted that file:

`rm peter@dx.pilot.json`

That appears to have cleaned it all up, and I'm no longer bothered by the "invalid grant" message and the shadow org.