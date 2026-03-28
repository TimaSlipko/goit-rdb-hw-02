-- STEP 1: 1NF
CREATE TABLE IF NOT EXISTS orders_1nf (
    order_id    INT          NOT NULL,
    product     VARCHAR(100) NOT NULL,
    quantity    INT          NOT NULL,
    address     VARCHAR(255) NOT NULL,
    order_date  DATE         NOT NULL,
    customer    VARCHAR(100) NOT NULL,
    PRIMARY KEY (order_id, product)
);

INSERT INTO orders_1nf VALUES
(101, 'Лептоп',  3, 'Хрещатик 1',    '2023-03-15', 'Мельник'),
(101, 'Мишка',   2, 'Хрещатик 1',    '2023-03-15', 'Мельник'),
(102, 'Принтер', 1, 'Басейна 2',      '2023-03-16', 'Шевченко'),
(103, 'Мишка',   4, 'Комп\'ютерна 3', '2023-03-17', 'Коваленко');

SELECT * FROM orders_1nf; -- screenshot p1_orders_1nf

-- STEP 2: 2NF
CREATE TABLE IF NOT EXISTS orders_2nf (
    order_id    INT          NOT NULL,
    address     VARCHAR(255) NOT NULL,
    order_date  DATE         NOT NULL,
    customer    VARCHAR(100) NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS order_items_2nf (
    order_id  INT          NOT NULL,
    product   VARCHAR(100) NOT NULL,
    quantity  INT          NOT NULL,
    PRIMARY KEY (order_id, product)
);

INSERT INTO orders_2nf VALUES
(101, 'Хрещатик 1',    '2023-03-15', 'Мельник'),
(102, 'Басейна 2',      '2023-03-16', 'Шевченко'),
(103, 'Комп\'ютерна 3', '2023-03-17', 'Коваленко');

INSERT INTO order_items_2nf VALUES
(101, 'Лептоп',  3),
(101, 'Мишка',   2),
(102, 'Принтер', 1),
(103, 'Мишка',   4);

SELECT * FROM orders_2nf;      -- screenshot p2_orders_2nf
SELECT * FROM order_items_2nf; -- screenshot p2_order_items_2nf

-- STEP 3: 3NF
CREATE TABLE IF NOT EXISTS customers (
    id      INT          NOT NULL AUTO_INCREMENT,
    name    VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS products (
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders (
    id          INT  NOT NULL AUTO_INCREMENT,
    customer_id INT  NOT NULL,
    order_date  DATE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id   INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_oi_order   FOREIGN KEY (order_id)   REFERENCES orders   (id),
    CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products (id)
);

INSERT INTO customers (name, address) VALUES
('Мельник',   'Хрещатик 1'),
('Шевченко',  'Басейна 2'),
('Коваленко', 'Комп\'ютерна 3');

INSERT INTO products (name) VALUES ('Лептоп'), ('Мишка'), ('Принтер');

INSERT INTO orders (customer_id, order_date) VALUES (1, '2023-03-15'), (2, '2023-03-16'), (3, '2023-03-17');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 3), (1, 2, 2), (2, 3, 1), (3, 2, 4);

SELECT * FROM customers;   -- screenshot p3_customers
SELECT * FROM products;    -- screenshot p3_products
SELECT * FROM orders;      -- screenshot p3_orders
SELECT * FROM order_items; -- screenshot p3_order_items
