FROM geeksltd/msharp-build:latest
ONBUILD COPY ./M#/Model/*.config ./M#/Model/
ONBUILD COPY ./Domain/*.config ./Domain/
ONBUILD COPY ./M#/UI/packages.config ./M#/UI/
ONBUILD COPY ./Website/packages.config ./Website/
ONBUILD RUN nuget restore ./M#/Model -PackagesDirectory ..\\..\\packages
ONBUILD RUN nuget restore ./M#/UI -PackagesDirectory ..\\..\\packages
ONBUILD RUN nuget restore ./Domain -PackagesDirectory ..\\packages
ONBUILD RUN nuget restore ./Website -PackagesDirectory ..\\packages
ONBUILD COPY . .
ONBUILD RUN msharp-build
