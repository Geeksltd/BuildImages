for /r %%i in (.\\*.csproj) do (type %%i | find /v "GCop" > %%i_temp && move /y %%i_temp %%i)