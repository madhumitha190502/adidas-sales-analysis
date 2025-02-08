# Adidas Sales Data Analysis Project

## 📌 Project Overview
This project analyzes Adidas sales data to derive key insights into revenue, profitability, and product performance. 
Using **SQL** for data cleaning, transformation, and analysis, and **Power BI** for visualization, 
we provide a comprehensive understanding of Adidas' sales trends across various dimensions.

## 📂 Dataset Information
- **Dataset Name**: Adidas US Sales Dataset
- **Source**: Kaggle
- **Format**: CSV
- **Attributes**:
  - Invoice Date
  - Retailer ID
  - Product
  - Region, State, City
  - Units Sold, Price per Unit, Total Sales
  - Operating Profit, Operating Margin
  - Sales Method

## 🛠️ Tools Used
- **SQL** (MySQL Workbench) - Data cleaning, transformation, and querying
- **Power BI** - Data visualization and dashboard creation

## 🔍 Data Preparation (SQL)
### 1. **Database & Table Setup**
- Created `adidas_sales_db` database and imported the dataset.
- Renamed table for better readability.

### 2. **Data Cleaning & Transformation**
- Converted **Invoice Date** to `DATE` format.
- Removed special characters (`$`, `,`) from numerical columns and converted them to appropriate data types.
- Checked and removed duplicate or missing values.
- Created new columns:
  - **Category**: Categorized products into `Footwear` or `Apparel`.
  - **Gender**: Classified products as `Men`, `Women`, or `Other`.
  - **Month**: Extracted month name from `Invoice Date`.

### 3. **Exploratory Data Analysis (SQL Queries)**
#### **Sales Performance Insights**
- Total revenue generated
- State and city with highest sales
- Best-performing product categories
- Most profitable products

#### **Gender-Based Sales Insights**
- Sales comparison for Men’s vs. Women’s products
- Best-selling products per gender
- Gender-wise revenue trends

#### **Time-Based Sales Trends**
- Monthly sales trends
- Best and worst performing quarters

#### **Sales Method & Retailer Insights**
- Sales comparison between Online vs. Offline methods
- Top 5 retailers by revenue and units sold

## 📊 Power BI Visualization
### **Dashboard Components**
- **Sales Overview**: Total revenue, operating profit, and best-selling products.
- **Regional Analysis**: State and city-wise performance.
- **Category Analysis**: Comparison of footwear vs. apparel sales.
- **Gender-Based Insights**: Men’s vs. Women’s product sales performance.
- **Sales Method Analysis**: Online vs. Offline revenue contribution.
- **Time Series Analysis**: Monthly and quarterly sales trends.

## 📌 Key Insights
- **Footwear category** generated the highest revenue.
- **Online sales** performed better than offline in revenue generation.
- **California & New York** were the top-performing states in sales.
- **Men’s products** contributed more to total revenue than Women’s.
- **Q3 (July-September)** had the highest sales.

## 🚀 Conclusion
By leveraging SQL for analysis and Power BI for visualization, this project offers valuable insights into Adidas’ sales trends. 
These findings can help optimize business strategies and improve sales performance.

## 📜 Future Enhancements
- Perform deeper **predictive analysis** on sales trends.
- Implement **real-time reporting** using dynamic Power BI dashboards.
- Incorporate **customer segmentation** for targeted marketing strategies.

---


