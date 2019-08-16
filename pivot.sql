SELECT * FROM test.pivot;

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT CONCAT('MAX(IF(property_name = ''',property_name,''', value_data, NULL)) AS ',
      property_name
    )
  ) INTO @sql
FROM test.pivot;

SET @sql = CONCAT('SELECT item_id, ', @sql, ' FROM test.pivot GROUP BY item_id');

-- SELECT  @sql;

prepare dstmt from @sql; 
execute dstmt; 
deallocate prepare dstmt; 


#
SELECT
  GROUP_CONCAT(
    CONCAT(
      ' MAX(IF(property_name = ''',
      t.property_name,
      ''', Value, NULL)) AS ',
      t.property_name
    )
  ) INTO @PivotQuery
FROM
  (SELECT
     Property
   FROM
     ProductOld
   GROUP BY
     Property) t;

SET @PivotQuery = CONCAT('SELECT ProductID,', @PivotQuery, ' FROM ProductOld GROUP BY ProductID');
#
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SELECT
  item_id,
  MAX(IF(property_name = 'color', value_data, NULL)) AS color,
  MAX(IF(property_name = 'size', value_data, NULL)) AS size,
  MAX(IF(property_name = 'weight', value_data, NULL)) AS weight,
  MAX(IF(property_name = 'length', value_data, NULL)) AS length
FROM
  pivot
GROUP BY
  item_id;
  
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;