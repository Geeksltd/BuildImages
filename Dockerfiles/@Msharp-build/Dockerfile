FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-ltsc2016

SHELL ["cmd", "/S", "/C"]
# Install Chocolatey
RUN powershell -NoProfile -InputFormat None Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) && \
    setx PATH "%ProgramData%\chocolatey\bin\;%PATH%;";

RUN choco install dotnetcore-sdk --version=3.1.402 -y && \
    setx PATH "%ProgramData%\dotnet\;%PATH%;";

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\\BuildTools && \
    setx PATH "c:\BuildTools\MSBuild\15.0\Bin\;%PATH%;";

# Install msharp-build
RUN dotnet tool install -g msharp-build --version 1.1.144 && \
    setx PATH "%USERPROFILE%\.dotnet\tools\;%PATH%;";
RUN msharp-build -tools

# Install Nuget
RUN npm install -g --prefix c:\tools\nuget nuget && \
	setx PATH "c:\tools\nuget\node_modules\nuget\bin\;%PATH%;"

# Install Git
RUN choco install git.install -y && \
    setx PATH "%ProgramFiles%\Git\bin\;%PATH%;"

# Add the Geeks.MS nuget source
RUN nuget sources add -Name "GeeksMS" -Source "http://nuget.geeksms.uat.co/nuge"
COPY NuGet.Config .

COPY GAC c:\\GAC
RUN nuget restore c:\\GAC -PackagesDirectory c:\\Windows\\Assembly

COPY Commands c:\\Commands
RUN setx PATH "c:\Commands;%PATH%;"

WORKDIR app