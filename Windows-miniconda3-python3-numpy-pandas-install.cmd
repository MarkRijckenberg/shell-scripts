REM Last update to this script on January 5, 2018

REM Prerequisite: Windows 10 64-bit

REM Prerequisite: https://chocolatey.org/install

REM run the following commands using cmd.exe with Administrator privileges:

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n useFipsCompliantChecksums

choco install miniconda3 

REM run the following commands with Administrator privileges

REM via Start menu/Programs/Anaconda3/Anaconda command line prompt:

##########################################################################
# only use conda in combination with spyder and python3.6+
# never use pip to install spyder application
# use conda to install spyder application
# never use pip to upgrade python packages to avoid corrupting spyder install
##########################################################################
conda install anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda update anaconda conda cython matplotlib numpy pandas scipy  sympy spyder pip
conda install dvc
conda install ipython 
conda install tornado 
conda install setuptools 
conda install seaborn
conda install beautifulsoup4 
conda install argparse
conda install sklearn 
conda install jupyter 
conda install streamlink
conda install mistune 
conda install networkx 
conda install py4j 
conda install runipy 
conda install socli
conda install scikit-image 
conda install scikit-learn 
conda install scipy-data_fitting
conda install statsmodels 
conda install jsonschema 
conda install pattern 
conda install instantmusic
conda install fire 
conda install boto3 
conda install mock 
conda install pytest 
conda install pytest-mock 
conda install bcolz 
conda install configobj 
conda install ipywidgets 
conda install nibabel 
conda install Pillow-SIMD 
conda install qgrid 
conda install tqdm 
conda install traitlets 
conda install visdom 
conda install filelock 
conda install spectral 
conda install elasticsearch 
conda install tensorflow-gpu

REM Check if all dependencies are installed by inspecting

REM Spyder/Help/Dependencies window in Spyder application
