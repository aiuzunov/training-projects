CREATE TABLE users(
	id SERIAL primary key,
	name TEXT NOT NULL ,
	username TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

CREATE TABLE employees(
	id SERIAL primary key,
	name TEXT NOT NULL ,
	username TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

CREATE TABLE tags(
	id SERIAL primary key,
	name TEXT NOT NULL UNIQUE
);


CREATE TABLE products(
	id SERIAL primary key,
	name TEXT NOT NULL UNIQUE,
	image TEXT NOT NULL,
	brand TEXT NOT NULL,
	price numeric NOT NULL,
	count_in_stock INT NOT NULL,
	description TEXT NOT NULL,
	create_date TEXT NOT NULL,
	edit_time TEXT
);

CREATE TABLE tags_products(
	id SERIAL,
	product_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY (tag_id) REFERENCES tags(id),
	FOREIGN KEY (product_id) REFERENCES products(id),
	primary key (product_id,tag_id)
);


CREATE TABLE products_details(
	id SERIAL primary key,
	product_id INT NOT NULL,
	size TEXT NOT NULL,
	color TEXT NOT NULL,
	gender TEXT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE addresses(
	id SERIAL primary key,
	user_id INT NOT NULL,
	address TEXT NOT NULL,
	city TEXT NOT NULL,
	postalcode TEXT NOT NULL,
	country TEXT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments(
	id SERIAL primary key,
	state TEXT NOT NULL,
	time_of_payment timestamp
);

CREATE TABLE orders(
	id SERIAL primary key,
	user_id INT NOT NULL,
	address_id INT NOT NULL,
	payment_id INT NOT NULL,
	created timestamp NOT NULL,
	modified timestamp,
	order_status TEXT NOT NULL,
	price numeric NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (address_id) REFERENCES addresses(id),
	FOREIGN KEY (payment_id) REFERENCES payments(id)
);


CREATE TABLE order_items(
	id SERIAL primary key,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE cart_items(
	id SERIAL primary key,
	user_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);