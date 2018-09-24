# escape=`
FROM microsoft/dotnet-framework-build as build
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\BuildTools 
ENV PATH="c:\BuildTools\MSBuild\15.0\Bin\;${PATH}";

#Install Chocolatey
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
ENV PATH="c:\ProgramData\chocolatey\bin;${PATH}";

#Install Node
RUN choco install nodejs-lts -y
ENV PATH="c:\Program Files\nodejs;${PATH}";

# Install Yarn
RUN npm install yarn -g --prefix c:\tools\yarn
ENV PATH="c:\tools\yarn;${PATH}";

# Install Nuget
RUN npm install -g --prefix c:\tools\nuget nuget
ENV PATH="c:\tools\nuget\node_modules\nuget\bin;${PATH}";

# Install TypeScript
RUN npm install -g --prefix c:\tools\typescript typescript
ENV PATH="c:\tools\typescript;${PATH}";

# Install WebPack
RUN npm install -g --prefix c:\tools\webpack webpack
ENV PATH="c:\tools\webpack;${PATH}";

# Install Bower 
RUN npm install bower -y --prefix c:\tools\bower
ENV PATH="c:\tools\bower;${PATH}";

CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]