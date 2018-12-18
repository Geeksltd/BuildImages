set ACCELERATE_PACKAGE_FILENAME=packages.json
call dotnet tool install accelerate-package-restore -g
call accelerate-package-restore extract --out %ACCELERATE_PACKAGE_FILENAME%
call docker build -t project-runtime --build-arg ACCELERATE_PACKAGE_FILENAME=%ACCELERATE_PACKAGE_FILENAME% -f Build.Dockerfile .