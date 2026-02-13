# e-commerce-sales-analysis


📌 Project Overview
This project is a SQL-based data analysis system designed to track customers, products, and sales performance. The goal is to simulate a real-world e-commerce backend where we can analyze revenue, customer behavior, and inventory trends.

🛠 Tech Stack
Database: SQL Server (T-SQL)

Concepts Used: Joins, Aggregate Functions, Normalization, Primary/Foreign Keys.

Tools: Microsoft SQL Server Management Studio (SSMS), dbdiagram.io (for ER Diagram).

📂 Database Schema
The database consists of 4 normalized tables:

Customers: Stores customer personal details.

Products: Inventory management (Price, Stock).

Orders: Links customers to their purchase dates.

OrderDetails: A junction table that links Orders to Products (allows multiple items per order).

🚀 Key Features & Queries
This project includes SQL scripts to answer business questions such as:

Revenue Analysis: Calculated total sales per month.

Top Customers: Identified the top 5 customers by total spending.

Best-Selling Products: Found which items are sold most frequently.

Customer Retention: Identified customers who haven't placed an order in the last 6 months.

💻 How to Run This Project
Open SQL Server Management Studio (SSMS).

Copy the script from e_commerce_tables.sql to create the tables and insert dummy data.

Run the analysis queries found in e_commerce_queries.sql to see the reports.
