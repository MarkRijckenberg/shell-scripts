REM Following .cmd Windows command script has been tested and works in Windows 8.1 Pro 64-bit:

REM Please run following commands in Windows command line (using cmd, NOT Powershell) as administrator:

mkdir C:\temp

cd c:\temp

echo "Update all currently installed choco packages:"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyPackageUpdater"

cup -y all

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo

echo "After running this script, please start RStudio. In the RStudio interface, please click on"

echo "'Help', then click on 'Check for Updates' and then click on 'Quit and Download' to get the newest version of RStudio"

echo on

pause

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install binroot"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install PowerShell"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pscx"
 
REM  the chocolatey package manager currently has 15055 packages (July 31,2015)
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install chocolatey"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyGUI"

REM  the nuget package manager currently has 40065 packages (July 31,2015)
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install nuget.commandline"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install nugetpackageexplorer"

REM Get E-mail clients and utilities

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install thunderbird"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install mozbackup"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install outlookviewer"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install outlookconverter"

REM Get web browsers

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Firefox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install google-chrome-x64"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Opera"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install qupzilla"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install flashplayerplugin"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install grepwin"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install geforce-game-ready-driver"

REM Get Internet download utilities:
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install Wget"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install git"
 
REM ############################################################################################### 
REM Close .cmd command line window and open a new .cmd window to run the next commands.
REM Run following commands in Windows command line (using cmd, NOT Powershell) as administrator:
REM ############################################################################################### 

REM If you are using the 32-bit version of Windows, use 

REM curl-7.46.0-win32-local.msi instead of
 
REM curl-7.46.0-win64-local.msi

set CURLFILENAME=curl-7.46.0-win64-local.msi

mkdir C:\temp

cd c:\temp

wget http://www.confusedbycode.com/curl/%CURLFILENAME%

msiexec /I  %CURLFILENAME% /quiet /passive

REM Get R and RStudio
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install r.project"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install R.Studio"

REM show list of locally installed packages - installed using choco package manager for Windows:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco list -lo"
 
REM jre8 installer hangs; so line below has been disabled
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install jre8"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip.install"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install cmder.portable -pre"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install flashplayeractivex"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install FoxitReader"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install belgium-eid-middleware -version 407.7466"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install alcohol52-free"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install daemontoolslite"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install aimp"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install vlc"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install clipgrab"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install 7zip.commandline"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install filezilla"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install dropbox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install skype"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install DotNet4.5"
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install paint.net"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install virtualbox"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install VBoxGuestAdditions.install"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install virtualbox.extensionpack"

REM install Android emulator, which depends on Virtualbox:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install andy"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install libreoffice"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install visioviewer2013"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pdf24"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install windirstat"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install nomacs"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install cpu-z"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install duplicatecommander -pre"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install qbittorrent"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install steam"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install teamviewer"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install hitmanpro"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ccleaner"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install emsisoft-anti-malware"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install combofix"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install vagrant"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install yumi"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install unetbootin"

REM Get device driver management utilities:

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install DellCommandUpdate"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install driverbooster"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install googleearth"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install bleachbit"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install classic-shell"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install javaruntime"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install citrix-receiver"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ie11"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install adblockplusie"

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo

echo "After running this script, please start RStudio. In the RStudio interface, please click on"

echo "'Help', then click on 'Check for Updates' and then click on 'Quit and Download' to get the newest version of RStudio"

echo on

pause


echo off

echo "Update all currently installed choco packages:"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyPackageUpdater"

cup -y all


