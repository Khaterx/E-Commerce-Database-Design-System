<<<<<<< .mine
# 🛒 E-Commerce Database Design System
=======
# 🛒 E-Commerce Database Design
>>>>>>> .theirs

A comprehensive database design for a typical e-commerce platform. This project includes Entity-Relationship Diagrams (ERD), relationship definitions, realistic sample data, and essential reporting queries to support analysis and business intelligence use cases.

---

## 📑 Table of Contents

A comprehensive database design for a typical e-commerce platform. This project includes Entity-Relationship Diagrams (ERD), relationship definitions, realistic sample data, and essential reporting queries to support analysis and business intelligence use cases.

---

## 📑 Table of Contents
- [ERD](/E-Commerce-database-design/README.md#Key Relationships)
- [Key Relationships](#-key-relationships)
- Realistic Data for Ecommerce
- Reporting
## E-Commerce ERD
![e-commerce-erd.png](e-commerce-erd.png)
### Key Relationships:
1. **Category to Products**: One-to-Many
    - A category can have many products
    - Product belongs to one category (nullable)
2. **Customer to Orders**: One-to-Many
    - A customer can place many orders
    - Each order belongs to exactly one customer
3. **Orders to OrderDetails**: One-to-Many
    - An order can have multiple line items
    - Each line item belongs to exactly one order 
4. **Products to OrderDetails**: One-to-Many
    - A product can appear in many order details
    - Each order detail references exactly one product
---
Ecommerce Schema:
[[02_Self_Learning/JAVA_SkillUp/Tasks/E-Commerce-database-design/assets/ecommerce_schema.sql]]

```SQL
CREATE SCHEMA ECOMMERCE;  
  
use ECOMMERCE;  
  
CREATE TABLE Category  
(  
    category_id   INT AUTO_INCREMENT,  
    category_name VARCHAR(50) NOT NULL,  
    CONSTRAINT pk_category_id PRIMARY KEY (category_id)  
);  
  
  
CREATE TABLE Customer  
(  
    customer_id INT AUTO_INCREMENT,  
    first_name  VARCHAR(50)  NOT NULL,  
    last_name   VARCHAR(50)  NOT NULL,  
    email       VARCHAR(100) NOT NULL,  
    password    VARCHAR(255) NOT NULL,  
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  
  
    CONSTRAINT pk_customer_id PRIMARY KEY (customer_id),  
    CONSTRAINT email_unique UNIQUE (email)  
);  
  
  
CREATE TABLE Products  
(  
    product_id     INT AUTO_INCREMENT,  
    category_id    INT,  
    name           VARCHAR(50)    NOT NULL,  
    description    VARCHAR(255),  
    price          DECIMAL(10, 2) NOT NULL,  
    stock_quantity INT     NOT NULL,  
  
    CONSTRAINT pk_product_id PRIMARY KEY (product_id),  
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES Category (category_id) ON DELETE SET NULL,  
    CONSTRAINT check_price CHECK ( price > 0 )  
  
);  
  
CREATE TABLE Orders  
(  
    order_id     INT AUTO_INCREMENT,  
    customer_id  INT,  
    order_date   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,  
    total_amount DECIMAL(10,2)   NOT NULL CHECK ( total_amount > 0 ),  
  
    CONSTRAINT pk_order_id PRIMARY KEY (order_id),  
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)  
);  
  
CREATE TABLE OrderDetails  
(  
    order_details_id INT AUTO_INCREMENT,  
    order_id         INT,  
    product_id       INT,  
    quantity         INT CHECK ( quantity > 0),  
    unit_price       DECIMAL(10,2) NOT NULL CHECK ( unit_price > 0 ),  
  
    CONSTRAINT pk_order_details_id PRIMARY KEY (order_details_id),  
    CONSTRAINT fk_orderDetails_order FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,  
    CONSTRAINT fk_orderDetails_product FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE CASCADE  
);
```

---
## 📈 Reporting & Analytics Queries

SQL queries for:
- Daily report of the total revenue for a specific date.
```SQL
SELECT sum(oDetails.quantity * oDetails.unit_price) AS totalRevenue  
FROM Orders as o  
         JOIN OrderDetails as oDetails ON o.order_id = oDetails.order_id  
WHERE order_date = :Date
GROUP BY DATE(order_date);

---

SELECT DATE(order_date) as report_date, SUM(total_amount) as total_revenue  
FROM Orders  
WHERE order_date = :date  
GROUP BY DATE(order_date);
```

- Monthly report of the top-selling products in a given month.
```SQL
SELECT DATE_FORMAT(O.order_date, '%Y-%m') SaleMonth,  
       P.name           as topSelling,  
       SUM(OD.quantity) as TotalQuantity  
FROM OrderDetails OD  
         JOIN Orders O ON OD.order_id = O.order_id  
         JOIN Products P ON OD.product_id = P.product_id  
WHERE DATE_FORMAT(O.order_date, '%Y-%m') = :date  
GROUP BY SaleMonth, OD.product_id, topSelling  
ORDER BY TotalQuantity DESC;
```

- Write a SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month. Include customer names and their total order amounts. Complex query.

```SQL

```


- query to search for all products with the word "camera" in either the product name or description.
```SQL
SELECT product_id, name AS ProductName  
FROM Products  
WHERE name LIKE '%camera%'  
OR description LIKE '%camera%';
```

- Can you design a query to suggest popular products in the same category for the same author, excluding the Purchased product from the recommendations?

```SQL

```

- Write a trigger to Create a sale history 'Above customer , product', when a new order is made in the "Orders" table, automatically generates a sale history record for that order, capturing details such as the order date, customer, product,
, total amount, and quantity. The trigger should be triggered on Order insertion.

```SQL
```

## in the product table
- Write a transaction query to lock the field quantity with product id = 211 from being updated

```SQL
```

- Write a transaction query to lock row with product id = 211 from being updated
```SQL

```

