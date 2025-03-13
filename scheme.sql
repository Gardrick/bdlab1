CREATE TYPE necessity_enum AS ENUM('necessary', 'not necessary');
CREATE TYPE sex_enum AS ENUM('male', 'female');

CREATE DOMAIN posint AS INTEGER CHECK (VALUE >= 0);

CREATE TABLE spaceship_systems (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    necessity necessity_enum NOT NULL DEFAULT 'not necessary',
    working BOOLEAN NOT NULL
);
CREATE TABLE fuel (
    id SERIAL PRIMARY KEY,
    type VARCHAR(200) NOT NULL,
    amount posint NOT NULL
);
CREATE TABLE coordinates (
    id SERIAL PRIMARY KEY,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    z INTEGER NOT NULL
);
CREATE TABLE space_object (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    coordinates INT REFERENCES coordinates(id) NOT NULL
);
CREATE TABLE orbit (
    id SERIAL PRIMARY KEY,
    target INT REFERENCES space_object(id) NOT NULL,
    height posint NOT NULL
);
CREATE TABLE spaceship (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    systems INT REFERENCES spaceship_systems(id),
    fuel INT REFERENCES fuel(id),
    orbit INT REFERENCES orbit(id)
);
CREATE TABLE expedition (
    spaceship_id INT REFERENCES spaceship(id),
    target_id INT REFERENCES space_object(id),
    CONSTRAINT expedition_id PRIMARY KEY (spaceship_id, target_id)
);
CREATE TABLE human (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    sex sex_enum NOT NULL
);
CREATE TABLE spaceship_crew (
    spaceship_id INT REFERENCES spaceship(id),
    human_id INT REFERENCES human(id),
    CONSTRAINT spaceship_crew_id PRIMARY KEY (spaceship_id, human_id)
);

-- example values
INSERT INTO spaceship_systems (name, necessity, working)
VALUES ('oxygen generator', 'necessary', true),
       ('gravity field', 'not necessary', true),
       ('emergency generator', 'necessary', false),
       ('pyrocharges', 'necessary', false);
INSERT INTO fuel (type, amount)
VALUES ('ammonium perchlorate', 100),
       ('hydrazine', 60);
INSERT INTO coordinates (x, y, z)
VALUES (1304, 100, 275),
       (1380, 108, 264);
INSERT INTO space_object (name, coordinates)
VALUES ('Jupiter', 1),
       ('dividing point', 2);
INSERT INTO orbit (target, height)
VALUES (1, 64);
INSERT INTO spaceship (name, systems, fuel, orbit)
VALUES ('Дискавери', 1, 2, 1),
       ('Леонов', 1, 1, 1);
INSERT INTO expedition (spaceship_id, target_id)
VALUES (1, 1),
       (2, 1);
INSERT INTO human (name, sex)
VALUES ('Курноу', 'male'),
       ('Чандра', 'female');
INSERT INTO spaceship_crew (spaceship_id, human_id)
VALUES (1, 1),
       (2, 2);