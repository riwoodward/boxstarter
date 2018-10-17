# Fresh install script for new PCs using Chocolatey and BoxStarter
# Robert Woodward, 2018

# Manual installs required for: Anaconda3, TexLive, Docker
# Portable software in Dropbox: Cmder, SublimeText, FilezillaFTP, ArsClip

# Usage: Run from command line: "START http://bit.ly/riw_setup" (note: this must open in Edge / IE)

# Disable user account control temporarily
Disable-UAC

# Show hidden files, protected files and known file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

# Remove unneccesary default software using Microsoft maintained GitHub list
$msurl = "https://raw.githubusercontent.com/Microsoft/windows-dev-box-setup-scripts/master/scripts/RemoveDefaultApps.ps1"
iex ((new-object net.webclient).DownloadString("$msurl"))

# Import config function library module
$giturl = "https://raw.githubusercontent.com/riwoodward/boxstarter/master/WindowsConfigLibrary.psm1"
iex ((new-object net.webclient).DownloadString("$giturl"))

# Windows config functions to run
$ConfigFunctions = @'
[
    "DisableWebSearch",
    "DisableAppSuggestions",
    "DisableCortana",
    "DisableStickyKeys",
    "DisableOneDrive",
    "DisableXboxFeatures",
    "UninstallOneDrive",
    "UninstallMsftBloat",
    "UninstallThirdPartyBloat",
    "HideTaskbarSearchBox",
    "HideTaskView",
    "HideTaskbarPeopleIcon",
    "UnpinStartMenuTiles",
    "UnpinTaskbarIcons",
    "RemoveDefaultPrinters",
    "ShowTaskManagerDetails"
]
'@

# Chocolatey packages to install
$ChocoInstalls = @(
	# Basics
    'firefox',
	'googlechrome',
	'skype',
	'dropbox',
	'teamviewer',
	'7zip.install',
	# Media
	'imagemagick.app',
	'inkscape', 
	'picasa',
	'vlc',
	'jpegview',
	'spotify',
	# Documents
	'adobereader',
	'sumatrapdf.install',
	'texstudio',
	'ghostscript.app',
	'mendeley', 
	# Development
	'git --params "/GitAndUnixToolsOnPath /NoAutoCrlf"',
	'vscode',
	'heroku-cli', 
	'strawberryperl',
	# Misc
	'silverlight', 
	'qttabbar', 
	'speccy', 
	'autohotkey', 
	'windirstat', 
	'everything',
	'google-backup-and-sync'
)


# Run specified config functions
$ConfigFunctions = $ConfigFunctions | ConvertFrom-Json
$ConfigFunctions | ForEach-Object {
    Invoke-Expression $_
}

# Run chocolatey install routines
foreach ($app in $ChocoInstalls) {
    choco install -y $app
}

 # Re-enable user account control
Enable-UAC

Write-Host -ForegroundColor:Green "Installation and configuration complete!"