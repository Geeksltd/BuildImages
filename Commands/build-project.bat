dotnet tool update -g replace-in-file 
replace-in-file -m replace-in-file.yaml 
remove-gcop-references 

.\Build.bat
