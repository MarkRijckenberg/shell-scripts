    REM Please run the following script to install python 3.5.1 and numpy in Windows as administrator:
    
    REM Please run following commands in Windows command line (using cmd, NOT Powershell) as administrator:
    
    mkdir C:\temp
    
    cd c:\temp
    
    echo "Update all currently installed choco packages:"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyPackageUpdater"
    
    cup -y all
    
    echo "Show list of locally installed packages - installed using choco package manager for Windows:"
    
    choco list -lo
    
    echo on
    
    pause
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
     
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install binroot"
     
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install PowerShell"
     
    REM  the chocolatey package manager currently has 15055 packages (July 31,2015)
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install chocolatey"
     
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyGUI"
    
    REM  the nuget package manager currently has 40065 packages (July 31,2015)
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install nuget.commandline"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install nugetpackageexplorer"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install python"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install numpy"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install dreampie"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pip"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install pycharm-community"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install miniconda3 "
    
    
    python -m pip install -U pip
    
    pip install -U setuptools
    
    pip install -U virtualenv
    
     conda update conda
    
     conda install numpy
     
     conda install -f -n py33 matplotlib
     
     conda install -f -n py33 pyparsing
     
     conda install -f -n py33 numpy
    
    echo "Update all currently installed choco packages:"
    
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "choco install ChocolateyPackageUpdater"
    
    cup -y all
    
    echo "Show list of locally installed packages - installed using choco package manager for Windows:"
    
    choco list -lo
