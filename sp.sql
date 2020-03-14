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