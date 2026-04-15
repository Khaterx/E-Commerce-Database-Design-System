CREATE SCHEMA ECOMMERCE;

use ECOMMERCE;

CREATE TABLE Category
(
    category_id   INT AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    description   VARCHAR(255),
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
