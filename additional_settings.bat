rem RIW config script for new Win10 PCs
rem Run this in Cmder [when sync'ed in Dropbox] with Admin privileges, after BoxStarter install [quick link: http://bit.ly/riw_config]

rem Set system environmental variables
setx IPYTHONDIR "C:\Dropbox\Apps\.ipython"
setx JUPYTER_CONFIG_DIR "C:\Dropbox\Apps\.jupyter"
setx PYTHONPATH "C:\Dropbox\Work\Code"
setx PATH "%PATH%;C:\Program Files\Inkscape;C:\Dropbox\Apps\sublime;"

rem Set up git
git config --global user.name "Robert Woodward"
git config --global user.email r.i.woodward@gmail.com

rem Set sublime text as default text editor for Windows
rem after: https://github.com/grumpydev/Sublime-Notepad-Replacement
call C:\Dropbox\Apps\sublime\ReplaceNotepad.bat

rem Default text-based files to Sublime Text
FTYPE SublimeTextFile=C:\Dropbox\Apps\sublime\sublime_text.exe "%1"
ASSOC .=SublimeTextFile
ASSOC .txt=SublimeTextFile
ASSOC .dat=SublimeTextFile
ASSOC .ini=SublimeTextFile
ASSOC .yml=SublimeTextFile
ASSOC .md=SublimeTextFile
ASSOC .rst=SublimeTextFile
ASSOC .gitignore=SublimeTextFile
ASSOC .hgignore=SublimeTextFile
ASSOC .cfg=SublimeTextFile
ASSOC .py=SublimeTextFile

rem Default PDFs to SumatraPDF
FTYPE PDFFile=C:\Dropbox\Apps\SumatraPDF\SumatraPDF.exe "%1"
ASSOC .pdf=PDFFile
ASSOC .PDF=PDFFile

rem Default .ahk files to AutoHotKey
FTYPE AHKFile="C:\Program Files\AutoHotkey\AutoHotkey.exe" "%1"
ASSOC .ahk=AHKFile

rem Copy AutoHotKey scripts into Windows startup folder
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%userprofile%\Start Menu\Programs\Startup\riw_macros.lnk');$s.TargetPath='C:\Dropbox\Apps\config\riw_macros.ahk';$s.Save()"
