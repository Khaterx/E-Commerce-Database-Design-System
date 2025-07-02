# 🛒 E-Commerce Database Design System | Web Store Database Architecture

A comprehensive database design for a typical e-commerce platform. This project includes Entity-Relationship Diagrams (ERD), relationship definitions, realistic sample data, and essential reporting queries to support analysis and business intelligence use cases.

---

## 📑 Table of Contents
- ERD
- Key Relationships
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
### Constraints Shown:
- Primary keys (PK)
- Foreign keys (FK)
- Optionality (SET NULL for category, CASCADE for order details)
- All relationships are properly represented with crow's foot notation

---
## 📈 Reporting
"# E-Commerce-Database-Design-System" 
