echo build mode : %1
if %1 ==publish ( 
	.\Build.bat -publish
	mklink /J output publish
	 ) ELSE ( 
	 .\Build.bat 	 
	 mklink /J output website
	 )