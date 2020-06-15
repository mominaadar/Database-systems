
--MOMINA ATIF DAR -- P18-0030 -- SECTION B

--SCHEMA OF ART GALLERY--

--DATA OF CUSTOMERS

CREATE TABLE CUSTOMER_DETAIL(
CUSTOMER_NAME VARCHAR(20) NOT NULL PRIMARY KEY,
PHONE VARCHAR(15),
ADDRESS VARCHAR(50)
);


--DATA OF ARTISTS

CREATE TABLE ARTIST_DETAIL(
ARTIST_CODE INT(5) NOT NULL PRIMARY KEY,
ARTIST_NAME VARCHAR(25)
);


--LIST OF PAINTINGS

CREATE TABLE PAINTINGS(
ARTIST_CODE INT(5) NOT NULL,
TITLE VARCHAR(25) NOT NULL PRIMARY KEY,
CONSTRAINT fk_paintings FOREIGN KEY(ARTIST_CODE) REFERENCES ARTIST_DETAIL(ARTIST_CODE) ON DELETE CASCADEON UPDATE CASCADE
);


--PURCHASES/TRANSACTIONS

CREATE TABLE PURCHASES(
CUSTOMER_NAME VARCHAR(20) NOT NULL,
ARTIST_CODE INT(5) NOT NULL,
TITLE VARCHAR(25) NOT NULL,
PURCHASE_DATE DATE NOT NULL,
SALES_PRICE DECIMAL(6,2),
CONSTRAINT fk_purchases FOREIGN KEY(CUSTOMER_NAME) REFERENCES CUSTOMER_DETAIL(CUSTOMER_NAME) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_purchases2 FOREIGN KEY(ARTIST_CODE) REFERENCES ARTIST_DETAIL(ARTIST_CODE) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_purchases3 FOREIGN KEY(TITLE) REFERENCES ARTIST_DETAIL(TITLE) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT pk_purchases PRIMARY KEY(CUSTOMER_NAME,TITLE,PURCHASE_DATE)
);