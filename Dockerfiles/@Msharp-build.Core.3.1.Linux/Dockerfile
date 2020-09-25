FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Update apt-get
RUN apt-get update -yq 

# Install nodejs
RUN apt install nodejs -yq && \
	apt install npm -yq

# Install Nuget
RUN apt-get install -yq

# TypeScript
RUN npm install -g typescript      

# Yarn
RUN npm install -g yarn

# Bower
RUN npm install -g bower      

# WebPack
RUN yarn add global add webpack

# Msharp-Build
RUN dotnet tool install -g msharp-build --version 1.1.149

# Add the Geeks.MS nuget source
RUN dotnet nuget add source "http://nuget.geeksms.uat.co/nuge" -n "GeeksMS"
COPY NuGet.Config .

WORKDIR app

ENV PATH="/root/.dotnet/tools:${PATH}"  

ONBUILD COPY ./M#/Model/#Model.csproj ./M#/Model/
ONBUILD COPY ./Domain/Domain.csproj ./Domain/
ONBUILD COPY ./M#/UI/#UI.csproj ./M#/UI/
ONBUILD COPY ./Website/Website.csproj ./Website/
ONBUILD RUN dotnet restore ./M#/Model/#Model.csproj
ONBUILD RUN dotnet restore ./M#/UI/#UI.csproj
ONBUILD RUN dotnet restore ./Website/Website.csproj
ONBUILD COPY . .
ONBUILD RUN if [ -f "./Build.sh" ]; then bash -c "./Build.sh";  else msharp-build -notools -publish; fi
