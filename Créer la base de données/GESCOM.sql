DROP DATABASE IF EXISTS 'GESCOM';
CREATE DATABASE 'GESCOM';
USE 'GESCOM';

CREATE TABLE products (
    sup_id
    sup_name
    sup_city
    sup_address
    sup_mail
    sup_phone
);

CREATE TABLE customers(
    cus_id
    cus_lastname
    cus_firstname
    cus_address
    cus_zipcode
    cus_city
    cus_mail
    cus_phone
);

CREATE TABLE orders (
    ord_id
    ord_order_date
    ord_ship_date
    ord_bill_date
    ord_reception_date
    ord_status
    cus_id
);

CREATE TABLE categories(
    cat_id
    cat_name
    cat_parent_id
);
