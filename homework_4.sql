CREATE DATABASE IF NOT EXISTS homework_4;

USE homework_4;

CREATE TABLE IF NOT EXISTS auto (
    regnum VARCHAR(10) PRIMARY KEY,
    mark VARCHAR(10),
    color VARCHAR(15),
    releasedt DATE,
    phonenum VARCHAR(15)
);

INSERT INTO auto (regnum, mark, color, releasedt, phonenum)
VALUES 
	(111114, 'LADA', 'красный', date'2008-01-01', '9152222221'),
	(111115, 'VOLVO', 'красный', date'2013-01-01', '9173333334'),
	(111116, 'BMW', 'синий', date'2015-01-01', '9173333334'),
	(111121, 'AUDI', 'синий', date'2009-01-01', '9173333332'),
    (111122, 'AUDI', 'синий', date'2011-01-01', '9213333336'),
    (111113, 'BMW', 'зеленый', date'2007-01-01', '9214444444'),
    (111126, 'LADA', 'зеленый', date'2005-01-01', null),
    (111117, 'BMW', 'синий', date'2005-01-01', null),
    (111119, 'LADA', 'синий', date'2017-01-01', 9213333331);

/* Задание 1. Вывести на экран, сколько машин каждого цвета для машин марок BMW и LADA. */

SELECT 
	mark, 
    color, 
    regnum
FROM auto
WHERE mark = 'BMW' OR mark = 'LADA';

SELECT 
	mark, 
    color, 
    regnum
FROM auto
WHERE mark IN ('BMW', 'LADA');

SELECT
    color,
    mark,
    COUNT(regnum)
FROM (
	SELECT 
		mark, 
        color, 
        regnum
	 FROM auto
	 WHERE mark = 'BMW' OR mark = 'LADA') AS bwm_lada_group
GROUP BY color, mark
ORDER BY mark;

SELECT
    color,
    mark,
    COUNT(regnum)
FROM auto
WHERE mark IN ('BMW', 'LADA') 
GROUP BY color, mark
ORDER BY mark;

SELECT 
	COUNT(*) 
FROM auto;

/* Задание 2. Вывести на экран марку авто(количество) и количество авто не этой марки. */

SELECT 
     mark,
    (SELECT COUNT(*) FROM auto) - COUNT(mark) AS other_mark_qty
FROM auto
GROUP BY mark
ORDER BY mark;

/* Задание 3. Даны 2 таблицы. Написать запрос, который вернет строки из таблицы test_a, 
id которых нет в таблице test_b, НЕ используя ключевого слова NOT. */

CREATE TABLE IF NOT EXISTS test_a (
  id INT,
  test VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS test_b (
	id INT
);

INSERT INTO test_a (id, test)
VALUES 
	(10, 'A'),
	(20, 'A'),
	(30, 'F'),
	(40, 'D'),
	(50, 'C');

INSERT INTO test_b (id)
VALUES 
	(10),
	(30),
	(50);

SELECT 
	test_a.*
FROM test_a
LEFT JOIN test_b
ON test_a.id = test_b.id
WHERE test_b.id IS NULL;
