CREATE DATABASE IF NOT EXISTS from_db DEFAULT CHARSET='utf8mb4';

use from_db;

CREATE TABLE `from_table` (
     id MEDIUMINT NOT NULL AUTO_INCREMENT,
     name CHAR(30) NOT NULL,
     PRIMARY KEY (id)
)

INSERT INTO from_table (name) VALUES
  ('dog'),('cat'),('penguin'),
  ('lax'),('whale'),('ostrich');
