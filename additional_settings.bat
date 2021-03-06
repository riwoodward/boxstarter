rem RIW config script for new Windows PCs
rem Run script with admin privileges, after Dropbox has synced Apps folder
rem Quick link: http://bit.ly/riw_config_script

rem Set system environmental variables
setx EDITOR "C:\Program Files\Microsoft VS Code\Code.exe"
setx IPYTHONDIR "C:\Dropbox\Apps\.ipython"
setx JUPYTER_CONFIG_DIR "C:\Dropbox\Apps\.jupyter"

rem Set up git
git config --global user.name "Robert Woodward"
git config --global user.email r.i.woodward@gmail.com

rem Default .ahk files to AutoHotKey
FTYPE AHKFile="C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "%1"
ASSOC .ahk=AHKFile

rem Copy AutoHotKey scripts into Windows startup folder
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\riw_macros.lnk');$s.TargetPath='C:\Dropbox\Apps\config\riw_macros.ahk';$s.Save()"

rem Add ArsClip in Dropbox to run on load
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\ArsClip.lnk');$s.TargetPath='C:\Dropbox\Apps\arsclip\ArsClip.exe';$s.Save()"
