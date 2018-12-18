FROM microsoft/dotnet-framework-build as build

# Install Chocolatey
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && \
    setx PATH "%ProgramData%\chocolatey\bin\;%PATH%";

RUN choco install dotnetcore-sdk -y && \
    setx PATH "%ProgramData%\dotnet\;%PATH%;";
# Install replace-in-file
RUN dotnet tool install -g msharp-build 
RUN msharp-build -tools

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\\BuildTools && \
    setx PATH "c:\BuildTools\MSBuild\15.0\Bin\;%PATH%";

# Install Nuget
RUN npm install -g --prefix c:\tools\nuget nuget && \
	setx PATH "c:\tools\nuget\node_modules\nuget\bin\;%PATH%"

# Install Git
RUN choco install git.install -y && \
    setx PATH "%ProgramFiles%\Git\bin\;%PATH%"

# Add the Geeks.MS nuget source
RUN nuget sources add -Name "GeeksMS" -Source "http://nuget.geeksms.uat.co/nuge"
COPY NuGet.Config .

COPY GAC c:\\GAC
RUN nuget restore c:\\GAC -PackagesDirectory c:\\Windows\\Assembly

# Empty the packages directory so that it can be mounted to the host's packages dir.
RUN rmdir "c:\\users\\containeradministrator\\.nuget\\packages" /s /q

COPY Commands c:\\Commands
RUN setx PATH "c:\Commands;%PATH%"

ONBUILD ARG ACCELERATE_PACKAGE_FILENAME
ONBUILD RUN dotnet tool update msharp-build
ONBUILD WORKDIR app
ONBUILD Copy $ACCELERATE_PACKAGE_FILENAME .
ONBUILD RUN "accelerate-package-restore -restore %ACCELERATE_PACKAGE_FILENAME%"
ONBUILD Copy . .
ONBUILD RUN build-project