DROP TABLE IF EXISTS users;
CREATE TABLE users(
	user_id INT NOT NULL ,
	name TEXT NOT NULL ,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL,
	isAdmin BOOL NOT NULL,
	primary key(user_id)
);


DROP TABLE IF EXISTS tags;
CREATE TABLE tags(
	tag_id INT NOT NULL,
	name TEXT NOT NULL UNIQUE,
	primary key(tag_id)
);


DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id INT NOT NULL ,
	tag_id INT NOT NULL,
	name TEXT NOT NULL UNIQUE,
	image TEXT NOT NULL,
	brand TEXT NOT NULL,
	price numeric NOT NULL,
	countInStock INT NOT NULL,
	description TEXT NOT NULL,
	primary key(product_id),
	FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);

DROP TABLE IF EXISTS address;
CREATE TABLE address(
	address_id INT NOT NULL ,
	user_id INT NOT NULL,
	address TEXT NOT NULL,
	city TEXT NOT NULL,
	postalcode TEXT NOT NULL,
	country TEXT NOT NULL,
	primary key(address_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id INT NOT NULL ,
	user_id INT NOT NULL,
	address_id INT NOT NULL,
	created timestamp NOT NULL,
	modified timestamp,
	orderStatus TEXT NOT NULL,
	price numeric NOT NULL,
	primary key(order_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (address_id) REFERENCES address(address_id)
);


DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item(
	order_item_id INT NOT NULL ,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	primary key(order_item_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

DROP TABLE IF EXISTS cart_item;
CREATE TABLE cart_item(
	cart_item_id INT NOT NULL ,
	user_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	primary key(cart_item_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);