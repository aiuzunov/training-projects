CREATE TABLE users(
	id BIGSERIAL primary key,
	name TEXT NOT NULL ,
	username TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	verified BOOLEAN DEFAULT NULL,
	password TEXT NOT NULL
);

CREATE UNIQUE INDEX idx_email_verified
ON employees(email, verified);

-- В таблицата username да е UNIQUE , паролите да не са plain text , да оправя email UNIQUE constraint-a,verified - UNIQUE
CREATE TABLE employees(
	id BIGSERIAL primary key,
	name TEXT NOT NULL ,
	username TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

CREATE TABLE tags(
	id BIGSERIAL primary key,
	name TEXT NOT NULL UNIQUE
);


CREATE TABLE products(
	id BIGSERIAL primary key,
	name TEXT NOT NULL UNIQUE,
	image TEXT NOT NULL,
	brand TEXT NOT NULL,
	price numeric NOT NULL,
	count_in_stock BIGINT NOT NULL,
	has_image BOOL NOT NULL DEFAULT FALSE,
	description TEXT NOT NULL,
	create_date TEXT NOT NULL,
	edit_time TEXT
);

CREATE TABLE tags_products(
	id BIGSERIAL,
	product_id BIGINT NOT NULL,
	tag_id BIGINT NOT NULL,
	FOREIGN KEY (tag_id) REFERENCES tags(id),
	FOREIGN KEY (product_id) REFERENCES products(id),
	primary key (product_id,tag_id)
);


CREATE TABLE products_details(
	id BIGSERIAL primary key,
	product_id BIGINT NOT NULL,
	size TEXT NOT NULL,
	color TEXT NOT NULL,
	gender TEXT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE addresses(
	id BIGSERIAL primary key,
	user_id BIGINT NOT NULL,
	address TEXT NOT NULL,
	city TEXT NOT NULL,
	postalcode TEXT NOT NULL,
	country TEXT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments(
	id BIGSERIAL primary key,
	state TEXT NOT NULL,
	time_of_payment timestamp NOT NULL,
	payment_sum NUMERIC NOT NULL,
	currency TEXT NOT NULL,
);
-- Сума на плащането
CREATE TABLE orders(
	id BIGSERIAL primary key,
	user_id BIGINT NOT NULL,
	address_id BIGINT NOT NULL,
	payment_id BIGINT NOT NULL,
	created timestamp NOT NULL,
	modified timestamp,
	order_status TEXT NOT NULL,
	price numeric NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (address_id) REFERENCES addresses(id),
	FOREIGN KEY (payment_id) REFERENCES payments(id)
);


CREATE TABLE order_items(
	id BIGSERIAL primary key,
	order_id BIGINT NOT NULL,
	product_id BIGINT NOT NULL,
	quantity BIGINT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE cart_items(
	id BIGSERIAL primary key,
	user_id BIGINT NOT NULL,
	product_id BIGINT NOT NULL,
	quantity BIGINT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (product_id) REFERENCES products(id)
);

-- BIGSERIAL // BIGINT