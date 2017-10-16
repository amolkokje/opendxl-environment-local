:: ----------------------------------
:: install python
set INSTALL_OPTS=ALLUSERS=1 ADDLOCAL=DefaultFeature,Tools,pip_feature
set SCRIPT_DIR=%cd%
set PYTHON_DIR=%cd%\python_64
if not exist %PYTHON_DIR% mkdir %PYTHON_DIR%

echo "Downloading 64-bit python ..."
powershell (New-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/2.7.11/python-2.7.11.amd64.msi','C:\temp\python_64.msi')
start /wait msiexec /i C:\temp\python_64.msi  /qn TARGETDIR=%PYTHON_DIR% %INSTALL_OPTS%
if not %ERRORLEVEL%==0 (
  echo "ERROR while installing python. Error Code=%ERRORLEVEL%"
)

:: ----------------------------------
:: set env vars
set WORKON_HOME=%SCRIPT_DIR%\virtualenvs
:: set global path
setx /m PATH "%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts"
:: set local path
set PATH=%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts


:: ----------------------------------
:: install pre-reqs
pip.exe install --upgrade virtualenvwrapper-win==1.2.1


:: ----------------------------------
:: create, and activate virtualenv
if not exist %WORKON_HOME% mkdir %WORKON_HOME%
call mkvirtualenv dxlclient


:: ----------------------------------
:: install libs
pip install --upgrade -r %SCRIPT_DIR%\dxlclient_requirements.txt
deactivate
