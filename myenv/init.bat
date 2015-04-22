@echo OFF

:: Personalise
SET MYENV_URL_HGRC=https://bitbucket.org/drummertom999/hgrc/raw/2eded6ab96303f1bfbd83e144a5d635be14188e6/hgrc
SET MYENV_URL_ST3=https://drummertom999@bitbucket.org/drummertom999/sublime-text-settings

:: Globals
SET MYENV_ROOT=%CMDER_ROOT%\myenv
SET MYENV_BIN=%CMDER_ROOT%\myenv\bin
SET MYENV_INIT_FLAG="%MYENV_ROOT%\initialised_flag"
SET MYENV_TEMP=%MYENV_ROOT%\temp
SET MYENV_SUBLIME=C:\Program Files\Sublime Text 3\sublime_text.exe

:: Add binaries to path
SET PATH=%PATH%;%MYENV_BIN%

:: Show splash screen
cat "%MYENV_ROOT%\splash"
echo. & echo.

:: First run?
if NOT exist %MYENV_INIT_FLAG% (

	mkdir "%MYENV_TEMP%"

	echo [+] Registering command line aliases
	xcopy "%MYENV_ROOT%/aliases" "%CMDER_ROOT%/config/aliases" /F /Y /I > nul 2>&1

	echo [+] Installing mercurial { Press enter when complete... }
	START "" http://mercurial.selenic.com/downloads
	PAUSE > nul 2>&1

	echo [+] Downloading Sublime Text 3 { Press enter when complete... }
	START "" http://www.sublimetext.com/3
	PAUSE > nul 2>&1

	echo [+] Downloading custom .hgrc file
	wget --output-document "%USERPROFILE%\.hgrc" --no-check-certificate %MYENV_URL_HGRC% > nul 2>&1

	echo [+] Downloading Sublime Text 3 user preferences
	hg clone %MYENV_URL_ST3% "%MYENV_TEMP%\sublime-text-settings" > nul 2>&1
	xcopy "%MYENV_TEMP%\sublime-text-settings\files" "%APPDATA%\Sublime Text 3\Packages\User" /F /Y /I > nul 2>&1
	START "%MYENV_SUBLIME%" "%APPDATA%\Sublime Text 3\Packages\User\final_instructions.txt"

	:: Finish up
	rmdir "%MYENV_TEMP%" /S /Q
	echo. & echo 1 > %MYENV_INIT_FLAG%
)

