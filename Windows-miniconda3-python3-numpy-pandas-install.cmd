REM Last update to this script on January 5, 2018

REM Prerequisite: Windows 10 64-bit

REM Prerequisite: https://chocolatey.org/install

REM run the following commands using cmd.exe with Administrator privileges:

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n useFipsCompliantChecksums

choco install miniconda3 

REM run the following commands with Administrator privileges

REM via Start menu/Programs/Anaconda3/Anaconda command line prompt:

conda install anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip

conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip

conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip

pip install --upgrade pip dvc

pip install --upgrade ipython tornado 

pip install --upgrade setuptools seaborn

pip install --upgrade beautifulsoup4 numpy scipy matplotlib argparse

pip install --upgrade sklearn jupyter streamlink

pip install --upgrade mistune networkx pandas py4j runipy socli

pip install --upgrade scikit-image scikit-learn scipy-data_fitting

pip install --upgrade statsmodels jsonschema pattern instantmusic

pip install --upgrade fire boto3 mock pytest pytest-mock bcolz configobj 

pip install --upgrade ipywidgets nibabel Pillow-SIMD qgrid tqdm traitlets 

pip install --upgrade visdom filelock spectral elasticsearch

pip install --upgrade tensorflow-gpu

REM Check if all dependencies are installed by inspecting

REM Spyder/Help/Dependencies window in Spyder application
