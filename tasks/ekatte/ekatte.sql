DROP TABLE IF EXISTS documents;
CREATE TABLE documents(
	document int NOT NULL UNIQUE,
	primary key(document),
	doc_kind VARCHAR(20) NOT NULL,
	doc_name VARCHAR(120) NOT NULL,
	doc_inst VARCHAR(100) NOT NULL,
	doc_num VARCHAR(9) NOT NULL,
	doc_date VARCHAR(13) NOT NULL,
	doc_act VARCHAR(13) NOT NULL,
	dv_danni VARCHAR(9) NOT NULL,
	dv_date VARCHAR(13) NOT NULL
);


DROP TABLE IF EXISTS tsb;
CREATE TABLE tsb(
	tsb VARCHAR(2) NOT NULL UNIQUE,
	primary key(tsb),
 	name VARCHAR(20) NOT NULL
);


DROP TABLE IF EXISTS kmetstva;
CREATE TABLE kmetstva(
 	kmetstvo varchar(8) NOT NULL UNIQUE,
 	ekatte VARCHAR(5) NOT NULL UNIQUE,
 	primary key(kmetstvo),
	name varchar(30) NOT NULL,
 	document int NOT NULL
);

DROP TABLE IF EXISTS reg;
CREATE TABLE reg(
	region VARCHAR(4) NOT NULL UNIQUE,
	primary key(region),
	name VARCHAR(50) NOT NULL,
	document int NOT NULL
);


DROP TABLE IF EXISTS oblasti;
CREATE TABLE oblasti(
	oblast VARCHAR(3) NOT NULL UNIQUE,
	ekatte VARCHAR(5) NOT NULL UNIQUE,
	name VARCHAR(30) NOT NULL,
	region VARCHAR(4) NOT NULL,
	document int NOT NULL,
	primary key(oblast),
	FOREIGN KEY (region) REFERENCES reg(region)
);

DROP TABLE IF EXISTS obshtini;
CREATE TABLE obshtini(
	obshtina VARCHAR(5) NOT NULL UNIQUE,
	ekatte VARCHAR(5) NOT NULL,
	name VARCHAR(30) NOT NULL,
	document INT NOT NULL,
	primary key(obshtina)
);

DROP TABLE IF EXISTS ekatte;
CREATE TABLE ekatte(
	ekatte VARCHAR(5) NOT NULL UNIQUE,
	primary key(ekatte),
	t_v_m VARCHAR(3) NOT NULL,
	name VARCHAR(50) NOT NULL,
	oblast CHAR(3) NOT NULL,
	obshtina CHAR(5) NOT NULL,
	kmetstvo CHAR(8) NOT NULL UNIQUE,
	kind INT NOT NULL,
	category INT NOT NULL,
	altitude INT NOT NULL,
	document INT NOT NULL,
	tsb VARCHAR(2) NOT NULL,
	FOREIGN KEY (oblast) REFERENCES oblasti(oblast),
	FOREIGN KEY (obshtina) REFERENCES obshtini(obshtina),
	FOREIGN KEY (kmetstvo) REFERENCES kmetstva(kmetstvo),
	FOREIGN KEY (document) REFERENCES documents(document),
	FOREIGN KEY (tsb) REFERENCES tsb(tsb)

);

DROP TABLE IF EXISTS raioni;
CREATE TABLE raioni(
	raion VARCHAR(8) NOT NULL UNIQUE,
	primary key(raion),
	name VARCHAR(20) NOT NULL,
	document int NOT NULL
);


DROP TABLE IF EXISTS Sof_rai;
CREATE TABLE Sof_rai(
	ekatte VARCHAR(5) NOT NULL UNIQUE,
	primary key(ekatte),
	raion VARCHAR(8) NOT NULL,
        name VARCHAR(50) NOT NULL,
        document int NOT NULL,
        FOREIGN KEY (raion) REFERENCES raioni(raion),
        FOREIGN KEY (ekatte) REFERENCES ekatte(ekatte)
);

DROP TABLE IF EXISTS sobr;
CREATE TABLE sobr(
	ekatte VARCHAR(5) NOT NULL UNIQUE,
	primary key(ekatte),
	name VARCHAR(50) NOT NULL,
	area VARCHAR(100) NOT NULL,
	document INT NOT NULL,
	FOREIGN KEY (document) REFERENCES documents(document)
);
