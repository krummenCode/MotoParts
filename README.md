# MotoParts
MotoParts is a full-stack eCommerce web application that allows users to shop for motocross parts. The application has user authentication with multiple roles that controls access. The project uses a local Microsoft SQL Server Database to store parts, dirt bikes, part brands & categories, user accounts (Full name, username, hashed password), user shopping cart info, and user roles.
(The application is not live and there is no payment integration, this project was developed for my capstone during bootcamp.)


### User Stories
An anon can view home, about, and contact pages.
An anon can sign up for an account.
An anon can sign in to an existing account.

A user can view all parts and filter parts by dirt bike through drop down menu.
A user can view a specific part in more detail.
A user can view, add, and delete parts from cart.
A user can view their account and delete it.

A moderator can view all parts in the database through a table.
A moderator can add, update and delete parts.
A moderator can delete their account.
 
An admin can view users in the database
An admin can update a users role and delete users
An admin can access all the part table functions a moderator can
An admin can delete a dirt bike and its parts (cascade delete)
An admin can view error table
An admin can view their account details


##Getting Started
To get MotoParts running on your Local Machine clone the MotoParts repo.

### Prerequisites
You must have the following programs installed before running: Visual Studio 2019 (Any edition, Community is free), Microsoft SQL Server 2019 (Developer or Express edition), and SQL Server Management Studio 2019 (SSMS).

* [Visual Studio 2019](https://visualstudio.microsoft.com/vs/)
* [Microsoft SQL Server 2019](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
* [SQL Server Management Studio 2019](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)

## Installing
1. Open up the 'MotoParts.sln' in Visual Studio and find the 'Web.config' file, here you want to modify the connectionString to contain your SQL Server Management Studio Server Name. (The Server Name can be found upon opening SSMS in the pop up window and also on the left side at the top of the object explorer.)
```c#
  <connectionStrings>
    <!-- 
      This connection string must be changed to your local sql server
      Replace "LAPTOP-385\SQLEXPRESS"
    -->
    <add name="dbConnection" connectionString="Server=LAPTOP-385\SQLEXPRESS;Database=MotoParts;Trusted_Connection=true;"/>
  </connectionStrings>
```


2. Copy the contents of 'script.sql' and paste them into an empty query in SQL Server Management studio. Once pasted in you will need to modify two file path strings at the top of the query.
```sql
( NAME = N'MotoParts', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\MotoParts.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MotoParts_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS02\MSSQL\DATA\MotoParts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
```

3. Highlight the whole query you just modified in SSMS and execute it.

4. Open up Visual Studio and in the Solution Explorer right click on the 'MotoPartsWebApp' and in the pop up select Set as Start Up Project.

5. Press the green play button to start the project.

## Built With
* MVC/ASP.NET Framework
* BootStrap 3
* SQL 
* Razor Syntax


