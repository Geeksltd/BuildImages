echo build mode : %1
if %1 ==publish ( .\Build.bat -publish ) ELSE ( .\Build.bat )