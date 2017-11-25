REM ApplySecureHostBaseline.cmd 
REM For Windows 10 64-bit machines only
REM Run following powershell command in cmd shell as Administrator:

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "mkdir c:\temp"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "cd c:\temp"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
 
REM @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y binroot"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y PowerShell"
 
REM  the chocolatey package manager currently has 15055 packages (July 31,2015)
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y chocolatey"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y ChocolateyGUI"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y axel"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y curl"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install -y unzip"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "rmdir c:\temp\Secure* -Recurse -force"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "rmdir c:\temp\LGPO* -Recurse -force"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "git clone https://github.com/iadgov/Secure-Host-Baseline"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Get-ChildItem -Path '.\Secure-Host-Baseline' -Recurse -Include '*.ps1','*.psm1' | Unblock-File -Verbose"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Import-Module -Name .\Secure-Host-Baseline\Scripts\GroupPolicy.psm1"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Import-Module -Name .\Secure-Host-Baseline\Compliance\Scripts\Compliance.psm1"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "cd c:\temp ; axel https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/telligent.evolution.components.attachments/01/4062/00/00/03/65/94/11/LGPO.zip"

REM Add-Type -AssemblyName System.IO.Compression.FileSystem
REM function Unzip
REM {
REM     param([string]$zipfile, [string]$outpath)
REM 
REM     [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
REM }

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "unzip C:\temp\LGPO.zip c:\temp\LGPO"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Invoke-ApplySecureHostBaseline -Path '.\Secure-Host-Baseline' -PolicyNames 'Adobe Reader','AppLocker','Certificates','Chrome','EMET','Internet Explorer','Office 2013','Office 2016','Windows','Windows Firewall' -ToolPath '.\LGPO\lgpo.exe'"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "cd Secure-Host-Baseline\Compliance\Scripts"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Test-Compliance -Path '..\..\Adobe Reader\Compliance\AdobeReaderDC.audit' -Verbose | Out-File ComplianceReport.txt"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Test-Compliance -Path '..\..\Chrome\Compliance\GoogleChrome.audit' -Verbose >ComplianceReport.txt"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Test-Compliance -Path '..\..\EMET\Compliance\EMET_5.5.audit' -Verbose >ComplianceReport.txt"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Test-Compliance -Path '..\..\Internet Explorer\Compliance\InternetExplorer11.audit' -Verbose >>ComplianceReport.txt"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Test-Compliance -Path '..\..\Windows\Compliance\Windows10.audit' -Verbose >ComplianceReport.txt"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Select-String -Path .\ComplianceReport.txt -Pattern 'FAILED'"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "Select-String -Path .\ComplianceReport.txt -Pattern 'WARN'"
