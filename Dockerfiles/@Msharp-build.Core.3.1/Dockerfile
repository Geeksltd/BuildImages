FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["cmd", "/S", "/C"]

# Install Chocolatey
RUN powershell -NoProfile -InputFormat None Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) && \
    setx PATH "%ProgramData%\chocolatey\bin\;%PATH%;";

# Install dotnetcore-sdk 3.1
RUN choco install dotnetcore-sdk --version=3.1.402 -y && \
    setx PATH "%ProgramData%\dotnet\;%PATH%;";

# Install nodejs
RUN choco install nodejs --version=14.12.0 -y

# Install Nuget
RUN npm install -g --prefix c:\tools\nuget nuget && \
	setx PATH "c:\tools\nuget\node_modules\nuget\bin\;%PATH%;"

# TypeScript
RUN npm install -g typescript      

# Yarn
RUN npm install -g yarn

# Bower
RUN npm install -g bower      

# WebPack
RUN yarn add global add webpack

# Msharp-Build
RUN dotnet tool install -g msharp-build

# Add the Geeks.MS nuget source
RUN nuget sources add -Name "GeeksMS" -Source "http://nuget.geeksms.uat.co/nuge"
COPY NuGet.Config .

COPY Commands c:\\Commands
RUN setx PATH "c:\Commands;%PATH%;"

WORKDIR app

ONBUILD COPY ./M#/Model/#Model.csproj ./M#/Model/
ONBUILD COPY ./Domain/Domain.csproj ./Domain/
ONBUILD COPY ./M#/UI/#UI.csproj ./M#/UI/
ONBUILD COPY ./Website/Website.csproj ./Website/
ONBUILD RUN dotnet restore ./M#/Model/#Model.csproj
ONBUILD RUN dotnet restore ./M#/UI/#UI.csproj
ONBUILD RUN dotnet restore ./Website/Website.csproj
ONBUILD COPY . .
ONBUILD RUN if exist Build.bat ( call Build.bat ) else ( msharp-build -publish)