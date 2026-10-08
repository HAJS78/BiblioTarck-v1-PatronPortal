# SpendWise 💸

> A full-stack group expense tracking and debt settlement mobile application built with **Flutter** (MVVM + Provider) and **.NET 8 RESTful API** (3-Tier Architecture with ADO.NET & MS SQL Server).





## 📖 Overview
**SpendWise** is a multi-tier group expense-sharing mobile solution designed to simplify shared finances and answer *"Who owes whom?"*. Users can register, create or join groups, log shared expenses, split costs equally or with custom amounts, track net balances in real time, and settle debts directly within the app.


## ✨ Key Features
- **User Authentication & Roles:** Secure signup/login supporting **Admin** and **Member** roles linked to specific **Group IDs**.
- **Password Recovery:** Search user email validation & reset mechanism.
- **Interactive Dashboard:** Real-time net balance visual tracking ("You Owe" / "You Are Owed") and recent transaction activity feed.
- **Flexible Expense Logging:**
  - Categorize expenses (Groceries, Internet, Shopping, Electricity, etc.).
  - Select participating group members and specify who paid.
  - Split expenses **Equally** or with **Custom** split allocations.
- **Detailed Activity Breakdown:** Inspect itemized expense details showing individual amounts paid and share settlement status (`Share Paid: Yes / No`).
- **Debt Settlement:** Comprehensive overview of lenders and lent amounts with direct debt settlement workflows.


## 🛠 Architecture

### **Frontend (Flutter Mobile Application)**
- **Framework:** Flutter (Dart)
- **Architecture Pattern:** Model-View-ViewModel (**MVVM**) with Repository & Service Layers.
- **Dependency Injection:** Service/Repository Interface-Implementation decoupling.
- **State Management:** `Provider` package.

Backend (.NET 8 Web API)
Framework: ASP.NET Core RESTful API (.NET 8)

Architecture: Classic 3-Tier Architecture

API Layer (SpendWise): REST Controllers (SpendWise.http, Program.cs).

Business Logic Layer (SpendWiseBLL): Core domain models (User, Group, Lending, ExpenseLog, UserExpense), services (ExpenseService, UserGroupService), and entity mappers.

Data Access Layer (SpendWiseDAL): Direct database operations built with ADO.NET (clsSettings.cs, UserGroupDAL.cs, data contracts).

Database Engine: Microsoft SQL Server .



🚀 Getting Started & Installation Prerequisites

 Flutter SDK: >=3.0.0

.NET SDK: 8.0

Database: Microsoft SQL Server (LocalDB, SQL Express, or Full Instance)

IDE: Visual Studio (Backend) & Visual Studio Code (Frontend)

🚀 How to Run:

Clone the repository:git@github.com:HAJS78/SpendWise-v1-.git

1. Database Setup
Open SQL Server Management Studio (SSMS).

Connect to your SQL Server instance.

Open and run the .sql script inside the DatabaseScript/ folder to generate tables and schema.

2. Backend API Setup (.NET 8)

Open Backend/SpendWise/SpendWise.sln in Visual Studio 

Update the connection string in Backend/SpendWiseDAL/clsSettings.cs

static class clsSettings
{

    static public string ConnectionString = "Server=YOUR_SERVER_NAME;Database=SpendWiseV1;User Id=YOUR_ID;Password=YOUR_Password;Encrypt=True;TrustServerCertificate=True;";

}

Build the project.

3. Frontend Setup (Flutter)

Select open folder in Visual Studio Code and navigate to spend_wise

Update the REST API endpoint URL inside your lib/Data/Services/Services_implementations

final String baseUrl = "http://10.0.2.2:YourBackendPort/api/ExpenseService/GetPaymentDetailsForExpenseActivity/";

Select an Emulator 

Start Debugging (before that you must make sure that the backend .NET app is running.It acts as 
                  the server)

## 🖼️ Screenshots

Screenshots are located in the **`ScreenShots`** folder.

### Authentication & Account Management

#### Login Screen
![Login Screen](ScreenShots/Login.png)

#### Signup Screen
![Signup Screen](ScreenShots/Signup.png)

#### Reset Password
![Reset Password](ScreenShots/ResetPassword.png)

### Expenses & Debt Management

#### User Dashboard
![User Dashboard](ScreenShots/Dashboard.png)

#### Add Expense Activity
![Add Expense Activity](ScreenShots/AddingExpenseActivity.png)

#### Expense Activity Details
![Expense Activity Details](ScreenShots/ExpenseActivityDetails.png)

#### Settle Debts
![Settle Debts](ScreenShots/SettleDebt.png)


## 🛠 Tech Stack 

Frontend : Flutter (Dart)
Backend  : ASP.NET Core RESTful API (.NET 8)
Database Engine: Microsoft SQL Server .

📜 License

This project is licensed under the MIT License —See LICENSE.md 


## 📅 Timeline

- Started:   February 2026 (15/2/2026)  
- Completed: May 2026      (19/5/2026) 
