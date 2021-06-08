SELECT DISTINCT(TABLE_NAME) FROM information_schema.columns
WHERE
    table_catalog='ASCEND_FULL'
AND
    table_schema='SF'
AND
    COLUMN_NAME != 'ID';
