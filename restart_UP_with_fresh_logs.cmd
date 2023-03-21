@echo off
net stop  Laetus.UP.Core.PlatformService.Line
rem echo "Service stopped, press enter when you're done editing config files"
rem pause
if exist c:\Laetus\UPLogs del /s /f /q c:\Laetus\UPLogs\*
net start  Laetus.UP.Core.PlatformService.Line
rem pause