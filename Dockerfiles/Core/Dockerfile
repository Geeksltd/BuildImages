FROM geeksltd/msharp-build:1.01
ONBUILD COPY ./M#/Model/#Model.csproj ./M#/Model/
ONBUILD COPY ./Domain/Domain.csproj ./Domain/
ONBUILD COPY ./M#/UI/#UI.csproj ./M#/UI/
ONBUILD COPY ./Website/Website.csproj ./Website/
ONBUILD RUN remove-gcop-references
ONBUILD RUN dotnet restore ./M#/Model/#Model.csproj
ONBUILD RUN dotnet restore ./M#/UI/#UI.csproj
ONBUILD RUN dotnet restore ./Website/Website.csproj
ONBUILD COPY . .
ONBUILD RUN msharp-build
