FROM microsoft/dotnet-framework-build as build

# Install Chocolatey
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && \
    setx PATH "%ProgramData%\chocolatey\bin\;%PATH%";

RUN choco install dotnetcore-sdk -y && \
    setx PATH "%ProgramData%\dotnet\;%PATH%";

# Install replace-in-file
RUN dotnet tool install -g replace-in-file

# Install NodeJs
RUN choco install nodejs.install -y && \
    setx PATH "%APPDATA%\npm\;%PATH%";

# Install Yarn
RUN npm install yarn --prefix "%ProgramFiles(x86)%\yarn" && \
    setx PATH "%ProgramFiles(x86)%\yarn\;%PATH%";

# Install TypeScript
RUN npm install -g typescript

# Install WebPack
RUN yarn global add webpack && \
    setx PATH "%APPDATA%\yarn\bin\;%PATH%";

# Install MSBuild
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\\TEMP\\vs_buildtools.exe
RUN C:\\TEMP\\vs_buildtools.exe --quiet --wait --norestart --nocache --installPath c:\\BuildTools && \
    setx PATH "c:\BuildTools\MSBuild\15.0\Bin\;%PATH%";

# Install Nuget
RUN npm install -g --prefix c:\tools\nuget nuget && \
	setx PATH "c:\tools\nuget\node_modules\nuget\bin;%PATH%"

# Add the Geeks.MS nuget source
RUN nuget sources add -Name "GeeksMS" -Source "http://nuget.geeksms.uat.co/nuge"