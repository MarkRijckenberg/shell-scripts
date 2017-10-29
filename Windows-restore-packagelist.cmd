REM Following .cmd Windows command script has been tested and works in Windows HVM in Qubes 

REM OS 3.2 or in normal install of Windows 7/8.1/10 Pro 64-bit without Qubes OS

REM In Qubes OS, connections to TCP ports 80 and 443 need to be open in Windows HVM

REM Furthermore, Windows HVM needs to use sys-firewall as NetVM, not whonix

REM Last modification date: 2017/05/22

REM Recommended to run this script on SSDs, not on conventional hard disks....

REM This script installs 62 Windows applications and requires 11 GB of free disk space to install

REM Please run following commands in Windows command line (using cmd, NOT Powershell) as administrator:

pause

mkdir C:\temp

cd c:\temp

echo "Update all currently installed choco packages:"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ChocolateyPackageUpdater"

cup -y all

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo

echo "After running this script, please start RStudio. In the RStudio interface, please click on"

echo "'Help', then click on 'Check for Updates' and then click on 'Quit and Download' to get the newest version of RStudio"

echo on

pause

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y binroot"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y PowerShell"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y pscx"
 
REM  the chocolatey package manager currently has 15055 packages (July 31,2015)
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y chocolatey"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ChocolateyGUI"

REM  the nuget package manager currently has 40065 packages (July 31,2015)
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y nuget.commandline"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y nugetpackageexplorer"

REM Install Internet security suite

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y 360ts"

REM Get E-mail clients and utilities

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y thunderbird"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y mozbackup"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y outlookviewer"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y outlookconverter"

REM Get web browsers

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y Firefox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y GoogleChrome"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y Opera"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y qupzilla"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y flashplayerplugin"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y grepwin"

REM streamlink is replacement for Minitube and allows streaming of Youtube video to VLC player:
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y streamlink"

REM ############################################################################################### 
REM xboot in Windows is similar to multisystem in Ubuntu
REM xboot is an easy-to-use utility for creating Multiboot USB/ISO
REM ############################################################################################### 

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y xboot"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y geforce-game-ready-driver"

REM Get Internet download utilities:
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y Wget"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y git"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y osquery"
 
REM ############################################################################################### 
REM Close .cmd command line window and open a new .cmd window to run the next commands.
REM Run following commands in Windows command line (using cmd, NOT Powershell) as administrator:
REM ############################################################################################### 

REM If you are using the 32-bit version of Windows, use 

REM curl-7.46.0-win32-local.msi instead of
 
REM curl-7.46.0-win64-local.msi

REM set CURLFILENAME=curl-7.46.0-win64-local.msi

REM mkdir C:\temp

REM cd c:\temp

REM wget http://www.confusedbycode.com/curl/%CURLFILENAME%

REM msiexec /I  %CURLFILENAME% /quiet /passive

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y curl"

REM ############################################################################################### 
REM get sha256sum.exe to check SHA256SUM values of downloaded .iso image files:
REM mkdir C:\temp
REM cd c:\temp
REM wget  http://www.labtestproject.com/files/sha256sum/sha256sum.exe
REM ############################################################################################### 

REM https://github.com/gurnec/HashCheck
REM https://chocolatey.org/packages/hashcheck
REM The HashCheck Shell Extension makes it easy for anyone to calculate and 
REM verify checksums and hashes (SHA3-256 and SHA3-512) from Windows Explorer
REM License: Standard 3-Clause BSD License
REM Download location #1: https://github.com/gurnec/HashCheck/releases/tag/v2.4.0
REM Download location #2: https://chocolatey.org/packages/hashcheck/2.4.0
REM Download location #3 (newest): https://ci.appveyor.com/project/gurnec/hashcheck/build/2.4.1.58-alpha/artifacts

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y hashcheck"

REM Get R and RStudio
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y r.project"
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y r.studio"

REM https://mran.microsoft.com/download/
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y microsoft-r-open"

REM show list of locally installed packages - installed using choco package manager for Windows:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco list -lo"
 
REM jre8 installer hangs; so line below has been disabled
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y jre8"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y 7zip.install"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y axel"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y 7zip.portable"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y cmder.portable -pre"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y flashplayeractivex"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y FoxitReader"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y eid-belgium"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y alcohol52-free"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y daemontoolslite"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y 7zip"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y aimp"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y vlc"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y mpc-hc"

REM Use http://madshi.net/madVR.zip  as DirectShow video renderer for mpc-hc video player when watching 4K movies

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y k-litecodecpackmega"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y clipgrab"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y 7zip.commandline"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y filezilla"
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y dropbox"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y skype"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y DotNet4.5"
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y paint.net"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y virtualbox"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y VBoxGuestAdditions.install"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y virtualbox.extensionpack"

REM install Android emulator, which depends on Virtualbox:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y andy"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y libreoffice"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y wps-office-free"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y visioviewer2013"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y pdf24"
 
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y windirstat"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y nomacs"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y cpu-z"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y duplicatecommander -pre"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y qbittorrent"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y steam"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y teamviewer"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y hitmanpro"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ccleaner"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y emsisoft-anti-malware"

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y combofix"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y vagrant"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y yumi"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y unetbootin"

REM Get device driver management utilities:

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y DellCommandUpdate"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y driverbooster"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y googleearth"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y bleachbit"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y classic-shell"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y javaruntime"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y citrix-receiver"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ie11"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y adblockplusie"

REM CD Burning software

REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y win32diskimager"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y rufus"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y cdburnerxp"

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo

echo "After running this script, please start RStudio. In the RStudio interface, please click on"

echo "'Help', then click on 'Check for Updates' and then click on 'Quit and Download' to get the newest version of RStudio"

echo on

pause


echo off

echo "Update all currently installed choco packages:"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ChocolateyPackageUpdater"

cup -y all

echo "Show list of locally installed packages - installed using choco package manager for Windows:"

choco list -lo
