-- Define tables in the raw schema.
USE olist_portfolio;

-- Drop existing objects first to avoid collisions.
DROP TABLE IF EXISTS raw.product_category_name_translation;
DROP TABLE IF EXISTS raw.olist_geolocation;
DROP TABLE IF EXISTS raw.olist_products;
DROP TABLE IF EXISTS raw.olist_sellers;
DROP TABLE IF EXISTS raw.olist_customers;
DROP TABLE IF EXISTS raw.olist_order_reviews;
DROP TABLE IF EXISTS raw.olist_order_payments;
DROP TABLE IF EXISTS raw.olist_order_items;
DROP TABLE IF EXISTS raw.olist_orders;

-- Create order and delivery related tables.
CREATE TABLE raw.olist_orders (
  order_id VARCHAR(64) NOT NULL,
  customer_id VARCHAR(64) NOT NULL,
  order_status VARCHAR(32) NOT NULL,
  order_purchase_timestamp DATETIME NULL,
  order_approved_at DATETIME NULL,
  order_delivered_carrier_date DATETIME NULL,
  order_delivered_customer_date DATETIME NULL,
  order_estimated_delivery_date DATETIME NULL,
  PRIMARY KEY (order_id),
  KEY idx_orders_customer_id (customer_id),
  KEY idx_orders_status (order_status),
  KEY idx_orders_purchase_ts (order_purchase_timestamp),
  KEY idx_orders_delivered_customer (order_delivered_customer_date),
  KEY idx_orders_estimated_delivery (order_estimated_delivery_date)
) ENGINE=InnoDB;

CREATE TABLE raw.olist_order_items (
  order_id VARCHAR(64) NOT NULL,
  order_item_id INT NOT NULL,
  product_id VARCHAR(64) NOT NULL,
  seller_id VARCHAR(64) NOT NULL,
  shipping_limit_date DATETIME NULL,
  price DECIMAL(12,2) NULL,
  freight_value DECIMAL(12,2) NULL,
  PRIMARY KEY (order_id, order_item_id),
  KEY idx_items_product_id (product_id),
  KEY idx_items_seller_id (seller_id)
) ENGINE=InnoDB;

CREATE TABLE raw.olist_order_payments (
  order_id VARCHAR(64) NOT NULL,
  payment_sequential INT NOT NULL,
  payment_type VARCHAR(32) NULL,
  payment_installments INT NULL,
  payment_value DECIMAL(12,2) NULL,
  PRIMARY KEY (order_id, payment_sequential),
  KEY idx_payments_type (payment_type)
) ENGINE=InnoDB;

CREATE TABLE raw.olist_order_reviews (
  review_id VARCHAR(64) NOT NULL,
  order_id VARCHAR(64) NOT NULL,
  review_score INT NULL,
  review_comment_title VARCHAR(255) NULL,
  review_comment_message TEXT NULL,
  review_creation_date DATETIME NULL,
  review_answer_timestamp DATETIME NULL,
  PRIMARY KEY (review_id),
  KEY idx_reviews_order_id (order_id),
  KEY idx_reviews_score (review_score)
) ENGINE=InnoDB;

-- Create customer and seller master tables.
CREATE TABLE raw.olist_customers (
  customer_id VARCHAR(64) NOT NULL,
  customer_unique_id VARCHAR(64) NOT NULL,
  customer_zip_code_prefix INT NULL,
  customer_city VARCHAR(255) NULL,
  customer_state VARCHAR(8) NULL,
  PRIMARY KEY (customer_id),
  KEY idx_customers_unique (customer_unique_id),
  KEY idx_customers_state (customer_state)
) ENGINE=InnoDB;

CREATE TABLE raw.olist_sellers (
  seller_id VARCHAR(64) NOT NULL,
  seller_zip_code_prefix INT NULL,
  seller_city VARCHAR(255) NULL,
  seller_state VARCHAR(8) NULL,
  PRIMARY KEY (seller_id),
  KEY idx_sellers_state (seller_state)
) ENGINE=InnoDB;

-- Create product and category tables.
CREATE TABLE raw.olist_products (
  product_id VARCHAR(64) NOT NULL,
  product_category_name VARCHAR(255) NULL,
  product_name_lenght INT NULL,
  product_description_lenght INT NULL,
  product_photos_qty INT NULL,
  product_weight_g INT NULL,
  product_length_cm INT NULL,
  product_height_cm INT NULL,
  product_width_cm INT NULL,
  PRIMARY KEY (product_id),
  KEY idx_products_category (product_category_name)
) ENGINE=InnoDB;

-- Create geolocation table.
CREATE TABLE raw.olist_geolocation (
  geolocation_id BIGINT NOT NULL AUTO_INCREMENT,
  geolocation_zip_code_prefix INT NULL,
  geolocation_lat DECIMAL(10,7) NULL,
  geolocation_lng DECIMAL(10,7) NULL,
  geolocation_city VARCHAR(255) NULL,
  geolocation_state VARCHAR(8) NULL,
  PRIMARY KEY (geolocation_id),
  KEY idx_geo_zip (geolocation_zip_code_prefix),
  KEY idx_geo_state (geolocation_state)
) ENGINE=InnoDB;

-- Create category translation table.
CREATE TABLE raw.product_category_name_translation (
  product_category_name VARCHAR(255) NOT NULL,
  product_category_name_english VARCHAR(255) NULL,
  PRIMARY KEY (product_category_name)
) ENGINE=InnoDB;
