# escape=`
FROM microsoft/dotnet-framework-build as build
SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\BuildTools 
ENV PATH="c:\BuildTools\MSBuild\15.0\Bin\${PATH}";

#Install Chocolatey
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
ENV PATH="c:\ProgramData\chocolatey\bin;${PATH}";

#Install Node
RUN choco install nodejs-lts -y
ENV PATH="c:\Program Files\nodejs;${PATH}";
# Install Yarn
RUN npm install yarn -g

# Install TypeScript
RUN choco install TypeScript -y

# Install WebPack
RUN yarn global add webpack

# Install Bower 
RUN choco install bower -y

CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]