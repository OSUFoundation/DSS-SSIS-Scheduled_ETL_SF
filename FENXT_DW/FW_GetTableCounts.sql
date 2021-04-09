DECLARE @TableCount TABLE ( Rowid int primary key identity , TableName varchar(150) , [RowCount] int )

INSERT INTO @TableCount ( TableName , [RowCount] )
EXEC dbo.sp_MSforeachtable @command1="SELECT '?', Count(*) FROM ?" 

SELECT TableName, [RowCount] FROM @TableCount

WHERE TableName NOT LIKE '%Temp%'	

	--- Can use WHERE clause to filter out TableNames for which you don't want to see row counts

ORDER BY [RowCount], TableName
