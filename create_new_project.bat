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

:: Create projects and install packages in one go
dotnet new mvc -n %ProjectName% --framework net8.0
dotnet sln add %ProjectName%

:: Create class libraries and install packages
for %%p in (Abstractions Repository Service Common) do (
    dotnet new classlib -n %ProjectName%.%%p --framework net8.0
    dotnet sln add %ProjectName%.%%p
)

:: Install packages for the Common project
dotnet add %ProjectName%.Common package itext7 --version 8.0.5
dotnet add %ProjectName%.Common package Microsoft.AspNet.Mvc --version 5.3.0
dotnet add %ProjectName%.Common package Microsoft.AspNetCore.Mvc --version 2.2.0
dotnet add %ProjectName%.Common package Microsoft.CodeAnalysis.Analyzers --version 3.3.4
dotnet add %ProjectName%.Common package Microsoft.CodeAnalysis.Common --version 4.11.0
dotnet add %ProjectName%.Common package Microsoft.CodeAnalysis.CSharp --version 4.11.0
dotnet add %ProjectName%.Common package Microsoft.Extensions.Configuration.Abstractions --version 8.0.0
dotnet add %ProjectName%.Common package Microsoft.Extensions.Http --version 8.0.0
dotnet add %ProjectName%.Common package ReportViewerCore.NETCore --version 15.1.22
dotnet add %ProjectName%.Common package Serilog --version 4.0.1
dotnet add %ProjectName%.Common package System.Net.Http --version 4.3.4

:: Install packages for the Repository project
dotnet add %ProjectName%.Repository package Dapper --version 2.1.35
dotnet add %ProjectName%.Repository package Npgsql --version 8.0.4
dotnet add %ProjectName%.Repository package System.Data.SqlClient --version 4.8.6

:: Adding project references in a single command
dotnet add %ProjectName% reference %ProjectName%.Abstractions %ProjectName%.Common %ProjectName%.Service %ProjectName%.Repository

:: Add project references to the Common library dependencies
dotnet add %ProjectName%.Common reference %ProjectName%.Abstractions

:: Add project references to the Repository library dependencies
dotnet add %ProjectName%.Repository reference %ProjectName%.Abstractions %ProjectName%.Common

:: Add project references to the Service library dependencies
dotnet add %ProjectName%.Service reference %ProjectName%.Abstractions %ProjectName%.Repository

:: Step 4: Restore and Build the Project
dotnet restore
dotnet build

:: Step 5: Display success message
echo.
echo Project '%ProjectName%' created successfully!
echo Opening the project directory...

:: Open the project directory in File Explorer
start "" "%cd%"

endlocal
pause
