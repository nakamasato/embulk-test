INSERT INTO from_table
    (name)
VALUES
    ('dog'),
    ('cat'),
    ('penguin'),
    ('lax'),
    ('whale'),
    ('ostrich');


DELIMITER $$
CREATE PROCEDURE generate_data()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 100000 DO
    INSERT INTO `from_table` (`name`)
    VALUES
        (CONVERT(ROUND(RAND()*100000000,0), CHAR(20)));
SET i = i + 1;
END WHILE;
SELECT count(*) FROM from_table;
END$$
DELIMITER ;

CALL generate_data();
