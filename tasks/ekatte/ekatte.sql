DROP TABLE IF EXISTS oblasti;
CREATE TABLE oblasti(
	oblast VARCHAR(3) NOT NULL UNIQUE,
	name VARCHAR(30) NOT NULL,
	primary key(oblast)
);

DROP TABLE IF EXISTS obshtini;
CREATE TABLE obshtini(
	obshtina VARCHAR(5) NOT NULL UNIQUE,
	name VARCHAR(30) NOT NULL,
	primary key(obshtina),
	oblast CHAR(3),
	FOREIGN KEY (oblast) REFERENCES oblasti(oblast)
);

DROP TABLE IF EXISTS ekatte;
CREATE TABLE ekatte(
	ekatte VARCHAR(5) NOT NULL UNIQUE,
	primary key(ekatte),
	t_v_m VARCHAR(3) NOT NULL,
	name VARCHAR(50) NOT NULL,
	obshtina CHAR(5) NOT NULL,
	FOREIGN KEY (obshtina) REFERENCES obshtini(obshtina)
);
