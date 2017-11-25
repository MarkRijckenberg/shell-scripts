REM ApplySecureHostBaseline.cmd 
REM For Windows 10 64-bit machines only
REM Run following powershell command in cmd shell as Administrator:
powershell -NoProfile -ExecutionPolicy unrestricted

REM Copy paste following commands into the unrestricted powershell session:
mkdir c:\temp
cd c:\temp
rmdir .\Secure* -Recurse -force
rmdir .\LGPO* -Recurse -force
git clone https://github.com/iadgov/Secure-Host-Baseline
Get-ChildItem -Path '.\Secure-Host-Baseline' -Recurse -Include '*.ps1','*.psm1' | Unblock-File -Verbose
Import-Module -Name .\Secure-Host-Baseline\Scripts\GroupPolicy.psm1
Import-Module -Name .\Secure-Host-Baseline\Compliance\Scripts\Compliance.psm1
axel https://msdnshared.blob.core.windows.net/media/TNBlogsFS/prod.evol.blogs.technet.com/telligent.evolution.components.attachments/01/4062/00/00/03/65/94/11/LGPO.zip

Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

unzip LGPO.zip .\LGPO

Invoke-ApplySecureHostBaseline -Path '.\Secure-Host-Baseline' -PolicyNames 'Adobe Reader','AppLocker','Certificates','Chrome','EMET','Internet Explorer','Office 2013','Office 2016','Windows','Windows Firewall' -ToolPath '.\LGPO\lgpo.exe'

cd Secure-Host-Baseline\Compliance\Scripts

Test-Compliance -Path '..\..\Adobe Reader\Compliance\AdobeReaderDC.audit' -Verbose | Out-File ComplianceReport.txt
Test-Compliance -Path '..\..\Chrome\Compliance\GoogleChrome.audit' -Verbose >ComplianceReport.txt
Test-Compliance -Path '..\..\EMET\Compliance\EMET_5.5.audit' -Verbose >ComplianceReport.txt
Test-Compliance -Path '..\..\Internet Explorer\Compliance\InternetExplorer11.audit' -Verbose >>ComplianceReport.txt
Test-Compliance -Path '..\..\Windows\Compliance\Windows10.audit' -Verbose >ComplianceReport.txt
Select-String -Path .\ComplianceReport.txt -Pattern 'FAILED'
Select-String -Path .\ComplianceReport.txt -Pattern 'WARN'



