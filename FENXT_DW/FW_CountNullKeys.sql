DECLARE @DBName nvarchar(40)
DECLARE @sqlstring nvarchar(260)
DECLARE @TablePrefixName nvarchar(40)

--- row variables for the loop
DECLARE @RowMax int
DECLARE @Counter int

SET @DBName = 'NONPROFIT_DW_FSYR'   --- change to database name
SET @sqlstring = N''

SET @TablePrefixName = N'FACT'   --- or use 'SUMMARY'
SET @TablePrefixName = @TablePrefixName + '%'


IF OBJECT_ID('tempdb..#DataDimIDFields') IS NOT NULL BEGIN
	DROP TABLE #DataDimIDFields   
END


CREATE TABLE #DataDimIDFields
	(
	ResultSetID  int identity primary key  
	, TABLE_QUALIFIER sysname
	, TABLE_OWNER sysname
	, TABLE_NAME sysname
	, COLUMN_NAME sysname
	, DATA_TYPE smallint
	, [TYPE_NAME] varchar(13)
	, [PRECISION] int
	, LENGTH int
	, SCALE smallint
	, RADIX smallint
	, NULLABLE smallint
	, REMARKS varchar(254)
	, COLUMN_DEF nvarchar(4000)
	, SQL_DATA_TYPE smallint
	, SQL_DATETIME_SUB smallint
	, CHAR_OCTET_LENGTH int
	, ORDINAL_POSITION int 
	, IS_NULLABLE varchar(254)
	, SS_DATA_TYPE tinyint
	)


IF OBJECT_ID('tempdb..#QueryBuilder') IS NOT NULL BEGIN
	DROP TABLE #QueryBuilder   
END

CREATE TABLE #QueryBuilder
	(
	ResultSetID  int identity primary key  
	, TABLE_QUALIFIER sysname
	, TABLE_OWNER sysname
	, TABLE_NAME varchar(80)
	, COLUMN_NAME varchar(80)
	, CODETABLEID varchar(120)
	, COLUMNValuesQuery nvarchar(350) --	
	)


---- third temp table to show the results of the null DimID counts

IF OBJECT_ID('tempdb..#QueryResults') IS NOT NULL BEGIN
	DROP TABLE #QueryResults   -- tempdb..
END

CREATE TABLE #QueryResults
	(
	ResultSetID  int identity primary key  
	, NULLKeyCount int
	, TableName varchar(120)
	, ColumnName varchar(120)
	)


/** --- Need to be able to iteratively build a query like this: 
	"SELECT Count( *  ) 
	FROM  [FACT_ACTION]  ## TABLE_OWNER . TABLE_NAME
WHERE  ## COLUMN_NAME IS NULL

**/

--- populate the first temp table
INSERT INTO #DataDimIDFields 
	EXEC sp_columns  @table_name = @TablePrefixName
			-- , @column_name = 'Constituent%'


--- populate the second temp table

INSERT INTO #QueryBuilder 
	SELECT  TABLE_QUALIFIER AS [TABLE_QUALIFIER] -- 2
		, TABLE_OWNER AS [TABLE_OWNER]	-- 3
		, CAST(TABLE_OWNER + '.' + TABLE_NAME AS varchar(80) ) AS [TABLE_NAME]  --- 4
		, CAST(COLUMN_NAME AS varchar(80) ) AS [COLUMN_NAME]  --- 5
		, CAST(TABLE_NAME + '_' + COLUMN_NAME AS varchar(120) ) AS [CODETABLEID] -- 6 
		, CAST('SELECT COUNT(*) AS NULLKeyCount, ''' + TABLE_NAME + ''' AS TableName , ''' + COLUMN_NAME + ''' AS ColumnName FROM ' + TABLE_OWNER + '.' + TABLE_NAME + ' WHERE ' + COLUMN_NAME + ' IS NULL ' + ' ' AS nvarchar(350) ) AS [COLUMNValuesQuery] -- 7
--- + ', ''' + TABLE_NAME + '_' + COLUMN_NAME + '''

	--	, DATA_TYPE 
	--	, [TYPE_NAME] 
	--	, [PRECISION] 
	--	, LENGTH
	--	, SCALE 
	--	, RADIX 
	--	, NULLABLE 
	--	, REMARKS 
	--	, COLUMN_DEF 
	--	, SQL_DATA_TYPE 
	--	, SQL_DATETIME_SUB 
	--	, CHAR_OCTET_LENGTH 
	--	, ORDINAL_POSITION 
	--	, IS_NULLABLE 
	--	, SS_DATA_TYPE

	FROM #DataDimIDFields

	WHERE 	[COLUMN_NAME] LIKE '%DimID'   --- could make this more modular by using a variable


	--- [TYPE_NAME] IN ('char', 'nchar', 'varchar', 'nvarchar', 'text', 'ntext')
	-- AND 

	ORDER BY TABLE_NAME  --- , ORDINAL_POSITION



--- Set the loop for populating the Results table
SET @Counter = 1
SET @RowMax = ( SELECT MAX(ResultSetID) FROM #QueryBuilder )

--- Begin the loop 
 
WHILE @Counter < @RowMax --2
	BEGIN

		SET @sqlstring = ( SELECT COLUMNValuesQuery FROM #QueryBuilder
		WHERE ResultSetID = @Counter )
		--- Row by row iteration through the #DataTextFields result set

		PRINT @sqlstring   --- In the messages tab, you can see the generated SQL that fires

		INSERT INTO #QueryResults
			(
			NULLKeyCount 
			, TableName
			, ColumnName
		)
		EXEC sp_executesql @sqlstring

		--- iterate the counter
		SET @Counter = @Counter + 1

END  --- WHILE LOOP


-- SQL to look into the temp tables
-- SELECT DISTINCT DATA_TYPE,  
-- FROM #DataDimIDFields

--SELECT *  
-- FROM #QueryBuilder


SELECT  TableName, ColumnName, NullKeyCount FROM #QueryResults
ORDER BY TableName, ColumnName


