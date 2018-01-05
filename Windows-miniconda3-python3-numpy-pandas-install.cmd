REM Last update to this script on January 5, 2018

REM Prerequisite: Windows 10 64-bit

REM https://chocolatey.org/install

REM run the following commands using cmd.exe with Administrator privileges:

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n useFipsCompliantChecksums

choco install miniconda3 

REM run the following commands with Administrator privileges

REM via Start menu/Programs/Anaconda3/Anaconda command line prompt:

conda install anaconda conda cython matplotlib numpy pandas scipy  sympy spyder

conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder

conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder

REM Check if all dependencies are installed by inspecting

REM Spyder/Help/Dependencies window in Spyder application
