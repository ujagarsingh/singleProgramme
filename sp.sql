select t1.* from  t1
where 
	not exists
	  ( select *
		from t2 
		where t1.enr_no = t2.enr_no) ;
## New
SELECT * FROM t2 
WHERE enr_no NOT IN(SELECT enr_no FROM t1);

## Alter

select t1.* from t1 join t2
    on t1.enr_no = t2.enr_no
where t1.name <> t2.name;

#   
set sql_safe_updates=0;
    
DELETE FROM t1 WHERE t1.NAME = (SELECT name FROM t1 GROUP BY name HAVING COUNT(name) > 1) as dt_1;

SELECT name FROM t1 GROUP BY name HAVING COUNT(name) > 1;


SELECT id, title FROM (
	SELECT id, title FROM t1
	UNION ALL
	SELECT id, title FROM t2
) 
tbl GROUP BY id, title HAVING count(*) = 2 ORDER BY id;

##-------------------------

SELECT t1.* FROM t1
LEFT OUTER JOIN t2
ON t1.id = t2.id
WHERE t2.id IS NULL;

##-------------------------

SELECT *
FROM t2
LEFT OUTER JOIN t1 ON (t1.id = t2.id)
WHERE t2.id IS NULL;

##-------------------------

select
    t1.*
from 
    t1
where 
	not exists
	  ( select *
		from t2 
		where t1.id = t2.id
		  and t2.title in ('row 1')
	  ) ;

##------------------------

SELECT id, name, enr_no
FROM
 (
   SELECT t1.id, t1.name, t1.enr_no
   FROM t1
   UNION ALL
   SELECT t2.id, t2.name, t2.enr_no
   FROM t2
)  t
GROUP BY id, name, enr_no
HAVING COUNT(*) = 1
ORDER BY id;

##------------------------
## working for new record

SELECT            a.*
FROM              t2 a
NATURAL LEFT JOIN t1 b
WHERE             b.name IS NULL;


-------
-------
-------
-------

## TC
select t1.* from  t1
where 
	not exists
	  ( select *
		from t2 
		where t1.enr_no = t2.enr_no) ;

## New
SELECT * FROM t2 
WHERE enr_no NOT IN(SELECT enr_no FROM t1);

## Alter
select t1.* from t1 join t2
    on t1.enr_no = t2.enr_no
where t1.name <> t2.name

##

UPDATE t1
	INNER JOIN t2 ON t1.enr_no = t2.enr_no
SET t1.name = t2.name
WHERE t1.id > 0


##
INSERT INTO t1(`name`, `enr_no`)
	(
		SELECT t2.name, t2.enr_no FROM t2 
		WHERE enr_no NOT IN(SELECT enr_no FROM t1)
    )



