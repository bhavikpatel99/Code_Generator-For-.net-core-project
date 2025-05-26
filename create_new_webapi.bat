@echo off
setlocal

:: Prompt for project name
set /p ProjectName="Enter the project name: "

:: Create the main project folder
md %ProjectName%

:: Navigate to the project folder
cd %ProjectName%

:: Create solution file inside the project folder
dotnet new sln --name %ProjectName%

:: Create main API project using .NET 8 Web API
dotnet new webapi -n %ProjectName%.API --framework net8.0
dotnet sln add %ProjectName%.API/%ProjectName%.API.csproj

:: Create supporting class libraries
for %%p in (Abstractions Repository Service Common) do (
    dotnet new classlib -n %ProjectName%.%%p --framework net8.0
    dotnet sln add %ProjectName%.%%p/%ProjectName%.%%p.csproj
)

:: ======== PACKAGE REFERENCES ========

:: Common Project
dotnet add %ProjectName%.Common package Serilog --version 4.0.1
dotnet add %ProjectName%.Common package Microsoft.Extensions.Configuration.Abstractions --version 8.0.0
dotnet add %ProjectName%.Common package Microsoft.Extensions.Http --version 8.0.0

:: Repository Project
dotnet add %ProjectName%.Repository package Dapper --version 2.1.35
dotnet add %ProjectName%.Repository package Npgsql --version 8.0.4
dotnet add %ProjectName%.Repository package System.Data.SqlClient --version 4.8.6

:: Project References
dotnet add %ProjectName%.API reference ^
    %ProjectName%.Abstractions ^
    %ProjectName%.Common ^
    %ProjectName%.Service ^
    %ProjectName%.Repository

dotnet add %ProjectName%.Common reference %ProjectName%.Abstractions
dotnet add %ProjectName%.Repository reference %ProjectName%.Abstractions %ProjectName%.Common
dotnet add %ProjectName%.Service reference %ProjectName%.Abstractions %ProjectName%.Repository

:: Restore and build
dotnet restore
dotnet build

echo.
echo Project '%ProjectName%' created successfully!
start "" "%cd%"

endlocal
pause
