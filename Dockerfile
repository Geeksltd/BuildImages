# escape=`
FROM microsoft/dotnet-framework-build as build
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]
ENV PATH="c:\Program Files\nodejs;c:\tools\yarn;c:\tools\webpack;c:\tools\typescript;c:\tools\bower;c:\BuildTools\MSBuild\15.0\Bin\;c:\ProgramData\chocolatey\bin;${PATH}";

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\BuildTools 

#Install Chocolatey
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Node
RUN choco install nodejs-lts -y 
# Install Yarn
RUN npm install yarn -g --prefix c:\tools\yarn 
# Install TypeScript
RUN npm install -g --prefix c:\tools\typescript typescript 
# Install WebPack
RUN npm install -g --prefix c:\tools\webpack webpack 
# Install Bower 
RUN npm install bower -y --prefix c:\tools\bower 

CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]