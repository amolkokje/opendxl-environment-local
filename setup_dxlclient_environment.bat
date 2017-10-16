@echo OFF
if %PROCESSOR_ARCHITECTURE%==AMD64 (		
  call %cd%\setup_dxlclient_environment_64bit.bat
) else (
  call %cd%\setup_dxlclient_environment_32bit.bat
)

