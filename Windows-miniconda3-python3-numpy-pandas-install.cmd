REM Get this and install it:

REM 64-bit Windows users:

REM https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe

REM 32-bit Windows users:

REM https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86.exe

REM run the following commands with Administrator privileges:

choco feature enable -n useFipsCompliantChecksums

choco install miniconda3 

REM run the following commands with Administrator privileges

REM via Start/Programs/Anaconda3/Anaconda command line prompt:

conda install anaconda conda  matplotlib numpy pandas scipy  spyder

conda update anaconda conda  matplotlib numpy pandas scipy  spyder
