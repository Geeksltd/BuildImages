FROM microsoft/aspnetcore-build

SHELL ["cmd", "/S", "/C"]
RUN npm install -g typescript      
RUN npm install -g yarn
RUN rmdir "%ProgramFiles%\nodejs\node_modules\bower" /Q /s
RUN npm install -g bower      
RUN yarn add global add webpack
RUN dotnet tool install -g msharp-build