# escape=`
FROM microsoft/dotnet-framework-build as build
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\BuildTools 
ENV PATH="c:\BuildTools\MSBuild\15.0\Bin\;${PATH}";