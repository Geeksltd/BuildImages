FROM geeksltd/msharp-build:1.05
RUN setx PATH "%Windir%\Microsoft.NET\Framework\v4.0.30319;%PATH%;"
ONBUILD COPY ./M#/Model/*.config ./M#/Model/
ONBUILD COPY ./Domain/*.config ./Domain/
ONBUILD COPY ./M#/UI/*.config ./M#/UI/
ONBUILD COPY ./Website/*.config ./Website/
ONBUILD RUN nuget restore ./M#/Model -PackagesDirectory packages
ONBUILD RUN nuget restore ./M#/UI -PackagesDirectory packages
ONBUILD RUN nuget restore ./Domain -PackagesDirectory packages
ONBUILD RUN nuget restore ./Website -PackagesDirectory packages
ONBUILD COPY . .
ONBUILD RUN msharp-build