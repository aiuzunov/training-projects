DROP TABLE IF EXISTS oblasti;
CREATE TABLE oblasti(
	oblast_id TEXT NOT NULL UNIQUE,
	name TEXT NOT NULL,
	primary key(oblast_id)
);

DROP TABLE IF EXISTS obshtini;
CREATE TABLE obshtini(
	obshtina_id TEXT NOT NULL UNIQUE,
	name TEXT NOT NULL,
	primary key(obshtina_id),
	oblast_id TEXT,
	FOREIGN KEY (oblast_id) REFERENCES oblasti(oblast_id)
);

DROP TABLE IF EXISTS selishta;
CREATE TABLE selishta(
	ekatte INT NOT NULL UNIQUE,
	primary key(ekatte),
	t_v_m TEXT NOT NULL,
	name TEXT NOT NULL,
	obshtina_id TEXT NOT NULL,
	FOREIGN KEY (obshtina_id) REFERENCES obshtini(obshtina_id)
);
