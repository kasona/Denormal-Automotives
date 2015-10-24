-- 4. In normalized.sql Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

\i scripts/denormal_data.sql;

CREATE TABLE IF NOT EXISTS make (
  id serial PRIMARY KEY NOT NULL,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
  );

CREATE TABLE IF NOT EXISTS model (
  id serial PRIMARY KEY NOT NULL,
  code character varying(125) NOT NULL,
  title character varying(125) NOT NULL
  );

CREATE TABLE IF NOT EXISTS normalized (
  id SERIAL PRIMARY KEY NOT NULL,
  make_id INTEGER REFERENCES make(id) NOT NULL,
  model_id INTEGER REFERENCES model(id) NOT NULL,
  year integer NOT NULL
  );

-- Pulls data from denormal script
INSERT INTO make (code, title)
SELECT DISTINCT car_models.make_code, car_models.make_title
FROM car_models;

INSERT INTO model (code, title)
SELECT DISTINCT car_models.model_code, car_models.model_title
FROM car_models;

-- 5. Using the resources that you now possess, In normal.sql Create queries to insert all of the data that was in the denormal_cars.car_models table, into the new normalized tables of the normal_cars database.

INSERT INTO normalized (make_id, model_id, year)
SELECT make.id, model.id, year
FROM make, model, car_models
WHERE make.title = car_models.make_title
AND make.code = car_models.make_code
AND model.title = car_models.model_title
AND model.code = car_models.model_code;



-- 6. In normal.sql Create a query to get a list of all make_title values in the car_models table. (should have 71 results)
SELECT DISTINCT make.title FROM normalized INNER JOIN make on (normalized.make_id = make.id);

-- 7. In normal.sql Create a query to list all model_title values where the make_code is 'VOLKS' (should have 27 results)
SELECT DISTINCT model.title FROM normalized INNER JOIN make on (normalized.make_id = make.id) INNER JOIN model on (normalized.model_id = model.id) WHERE make.code = 'VOLKS';

-- 8. In normal.sql Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM' (should have 136 rows)
SELECT make.code, model.code, model.title FROM normalized INNER JOIN make on (normalized.make_id = make.id) INNER JOIN model on (normalized.model_id = model.id) WHERE make.code = 'LAM';

-- 9. In normal.sql Create a query to list all fields from all car_models in years between 2010 and 2015 (should have 7884 rows)
SELECT * FROM normalized WHERE year >= 2010 AND year <= 2015;