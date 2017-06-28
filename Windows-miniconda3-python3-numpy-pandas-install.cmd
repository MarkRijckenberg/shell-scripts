REM Run this script in Powershell with Administrator privileges

REM Get this and install it:

REM 64-bit Windows users:

REM https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe

REM 32-bit Windows users:

REM https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86.exe

REM After installing Miniconda3, run the following commands on the command line:

choco feature enable -n useFipsCompliantChecksums

choco install miniconda3

conda update conda

conda install numpy matplotlib scipy pandas spyder

REM python
