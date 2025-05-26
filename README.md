# .NET Core Project Generator

This batch script is a .NET Core project generator designed to quickly scaffold a new **Web API** or **MVC** web project along with supporting class libraries and their necessary dependencies.

---

## 🔧 Script Variants

### 1. **Web API Version (Default / Recommended for Microservices)**

This version of the script scaffolds a clean **.NET 8 Web API project** using Clean Architecture principles.

#### ✅ What's Included:
- Creates a `.NET 8 Web API` project as the main application.
- Class libraries:
  - `Abstractions`: Interfaces and contracts
  - `Repository`: Data access layer using Dapper
  - `Service`: Business logic
  - `Common`: Logging, shared utilities
- Automatically installs key NuGet packages:
  - `Serilog`, `Dapper`, `Npgsql`, `SqlClient`, and configuration packages
- Adds all necessary **project references** between layers
- Builds the project and opens the solution folder for development

---

### 2. **MVC Version (Original Template)**

The MVC version of the script scaffolds a **.NET 8 MVC** project with dynamic view support.

---

## 📝 Script Description (MVC Version)

The script automates the creation of a .NET Core MVC web project with associated class libraries (Abstractions, Repository, Service, Common). It installs necessary NuGet packages, sets up project references, restores, builds the solution.

---

## ✨ Key Features

### 1. **Project Initialization**
- Prompts the user for the project name
- Creates a new **MVC** project targeting .NET 8.0
- Installs Razor Runtime Compilation for dynamic view updates *(MVC version only)*

### 2. **Class Library Setup**
- Creates four supporting class libraries:
  - `Abstractions`
  - `Repository`
  - `Service`
  - `Common`

### 3. **NuGet Package Installation**
- `Common`:
  - `iText7`, `Serilog`, `Microsoft.CodeAnalysis`, `ReportViewerCore`
- `Repository`:
  - `Dapper`, `Npgsql`, `System.Data.SqlClient`

### 4. **Project Referencing**
- Ensures proper project dependencies:
  - `API/MVC` → All libraries
  - `Service` → `Repository`, `Abstractions`
  - `Repository` → `Common`, `Abstractions`
  - `Common` → `Abstractions`

### 5. **Build and Restore**
- Runs `dotnet restore` and `dotnet build` to verify dependencies and compilation

### 6. **Opens in file explorer**
- Automatically launches the project folder.

---

## 🎯 Purpose

This script is ideal for:
- Quickly scaffolding modular .NET projects
- Following Clean Architecture principles
- Speeding up onboarding and development setup

---

## 🚀 Getting Started

```bash
# Run the batch file
setup-dotnet-project.bat

# When prompted, enter your desired project name
