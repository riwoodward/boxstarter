<#
Fresh install script for new PCs using Chocolatey and BoxStarter
Robert Woodward, 2019

Manual installs required for: Anaconda Python, Julia, TexLive, Docker, VS Build Tools
Portable software in Dropbox: FilezillaFTP, ArsClip

Usage:
    Run from command line: "start http://boxstarter.org/package/url?url_of_this_script"
    (or use the quick link: "start www.bit.ly/riw_setup")

    Or to run with disabled restarts: "start http://boxstarter.org/package/nr/url?url_of_this_script"

    (note: this must open in Edge / IE)

#>

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
	"HideTaskbarInkWorkspaceButton",
    "UnpinStartMenuTiles",
    "UnpinTaskbarIcons",
    "RemoveDefaultPrinters",
    "ShowTaskManagerDetails"
]
'@

# Chocolatey packages to install
$ChocoInstalls = @(
	'chocolatey',
	# Basics
	'cmder',
    'firefox',
	'googlechrome',
	'skype',
	'dropbox',
	'7zip.install',
	# Media
	'imagemagick.app',
	'inkscape',
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
	# 'strawberryperl',
	'nodejs',
	'msys2'
	# Misc
	'silverlight',
	'qttabbar',
	'speccy',
	'autohotkey',
	'windirstat',
	'everything',
	'google-backup-and-sync',
	# Install Wox (but reject Python3 dependency since we'll use Anaconda)
	'--ignore-dependencies wox'
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

# Enable Windows Subsystem Linux
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Clear desktop
Get-ChildItem $env:USERPROFILE\Desktop\*.lnk|ForEach-Object { Remove-Item $_ }

# Enaable SSH agent for key authentication
Set-Service -name "ssh-agent" -startuptype "automatic"

# Re-enable user account control
Enable-UAC

Write-Host -ForegroundColor:Green "****************************************"
Write-Host -ForegroundColor:Green "Installation and configuration complete!"
Write-Host -ForegroundColor:Green "****************************************"
