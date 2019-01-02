FROM microsoft/dotnet-framework-build as build

# Install Chocolatey
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && \
    setx PATH "%ProgramData%\chocolatey\bin\;%PATH%";

RUN choco install dotnetcore-sdk -y && \
    setx PATH "%ProgramData%\dotnet\;%PATH%;";

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\\BuildTools && \
    setx PATH "c:\BuildTools\MSBuild\15.0\Bin\;%PATH%";

# Install replace-in-file
RUN dotnet tool install -g msharp-build 
RUN msharp-build -tools

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


COPY Commands c:\\Commands
RUN setx PATH "c:\Commands;%PATH%"

ONBUILD WORKDIR app
ONBUILD COPY ./M#/Model/#Model.csproj ./M#/Model/
ONBUILD COPY ./Domain/Domain.csproj ./Domain/
ONBUILD COPY ./M#/UI/#UI.csproj ./M#/UI/
ONBUILD COPY ./Website/Website.csproj ./Website/
ONBUILD RUN remove-gcop-references
ONBUILD RUN dotnet restore ./M#/Model/#Model.csproj
ONBUILD RUN dotnet restore ./M#/UI/#UI.csproj
ONBUILD RUN dotnet restore ./Website/Website.csproj
ONBUILD COPY . .
ONBUILD RUN build-project
