FROM microsoft/aspnetcore-build

SHELL ["cmd", "/S", "/C"]
RUN npm install -g typescript      
RUN npm install -g yarn
RUN rmdir "%ProgramFiles%\nodejs\node_modules\bower" /Q /s
RUN npm install -g bower      
RUN yarn add global add webpack
RUN dotnet tool install -g msharp-build

# Add the Geeks.MS nuget source
RUN nuget sources add -Name "GeeksMS" -Source "http://nuget.geeksms.uat.co/nuge"
COPY NuGet.Config .