-- ============== Denormal Cars =============================
-- 1. Create a new postgres user named denormal_user
-- CREATE USER denormal_user;

-- 2.Create a new database named denormal_cars owned by denormal_user
-- CREATE DATABASE denormal_cars OWNER denormal_user;

-- 3. Run the provided scripts/denormal_data.sql script on the denormal_cars database
-- \i scripts/denormal_data.sql;

-- 4. Inspect the table named car_models by running \dS and look at the data using some SELECT statements
-- \dS
-- SELECT * FROM pg_database;
-- SELECT * FROM pg_attribute;
-- SELECT * FROM pg_language;
-- SELECT * FROM pg_type;