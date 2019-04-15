FROM geeksltd/msharp-build:1.04
RUN setx PATH "%Windir%\Microsoft.NET\Framework\v4.0.30319;%PATH%;"
ONBUILD COPY ./M#/Model/packages.config ./M#/Model/
ONBUILD COPY ./Domain/packages.config ./Domain/
ONBUILD COPY ./M#/UI/packages.config ./M#/UI/
ONBUILD COPY ./Website/packages.config ./Website/
ONBUILD RUN nuget restore ./M#/Model -PackagesDirectory packages
ONBUILD RUN nuget restore ./M#/UI -PackagesDirectory packages
ONBUILD RUN nuget restore ./Domain -PackagesDirectory packages
ONBUILD RUN nuget restore ./Website -PackagesDirectory packages
ONBUILD COPY . .
ONBUILD RUN msharp-build
ONBUILD RUN aspnet_compiler -p Website -v Published