/*????????? ?????????? ????? ??????????*/
USE AdventureWorks2012;

--------------------------------------------------------------------------
--                   ???????? ??????????? IF..ELSE
--------------------------------------------------------------------------

DECLARE @myVar varchar(10); 

--SET @myVar = 'Hello World!!!'

-- ? ???????? ??????????? IF, ????????? ?????????: @myVar is NULL 
IF @myVar is NULL 
	PRINT ('???????? myVar ?? ??????');   -- ???? ??????? ????????????? ??????????.
ELSE				
	PRINT @myVar;                         -- ????? ???? ??????? ?? ????????????? ??????????.


--------------------------------------------------------------------------
--                        ???????? EXISTS
--------------------------------------------------------------------------
-- ???????? EXISTS ?????????? ???????? TRUE ??? FALSE, ? ??????????? ?? ????
-- ??????? ?? ??????????????? ??????? SELECT ?????? 

IF EXISTS (SELECT * FROM Person.Address WHERE City = 'Kyiv') -- ? ????? ??????? ????????? ??? ????? (?????? ???????????? ????)
	PRINT 'We have staff from the city Seattle'
ELSE
	PRINT 'We have no employees of the city Seattle'
	
----------------------------------------------------------------------------
USE ShopDB;

-- ????????? ??????? sys.schemas, sys.tables

-- ??????? sys.schemas ???????? ?????????? ? ?????? ?????????? ? ????? ??

SELECT * FROM sys.schemas 

-- ??????? sys.tables ???????? ?????????? ? ???????? ?????????? ? ????? ??

SELECT * FROM sys.tables 

----------------------------------------------------------------------------

--?????? ???????? ??????? TestTable ? ????????????? ?? ??????? ?? ??? ?????.
IF NOT EXISTS (    
				SELECT s.name,t.name
				FROM sys.schemas AS s					-- schemas - ????????? ??????? ???????? ?????????? ? ??????
					JOIN sys.tables AS t				-- tables - ????????? ??????? ???????? ?????????? ? ????????
					 ON s.schema_id = t.schema_id	-- ??????? ??????? ??????????? ? ?????
				WHERE s.name = 'dbo'				-- ??? ????? dbo
					AND t.name = 'TestTable'		-- ? ??????? TestTable
				)				
	CREATE TABLE TestTable --??????? ??????? ???? ??? ?? ??????????
		(
			Col1 int,
			Col2 varchar(20)
		)	
ELSE
	PRINT '??????? TestTable ??? ??????????!' -- ??????? ????????? ???? ??????????
----------------------------------------------------------------------------
		
----- ?????????? ?????????? ? ????? -----

DROP TABLE TestTable;
-- ???? ?????????? ????????? ????????? ??????????, ?? ????????? ? ????? BEGIN ... END
IF NOT EXISTS (    
				SELECT s.name,t.name
				FROM sys.schemas s 
				JOIN sys.tables t  
					ON s.schema_id=t.schema_id 
				WHERE s.name = 'dbo' 
					AND t.name = 'TestTable' 
				)	
				
	BEGIN   -- ?????? ?????
		PRINT '??????? TestTable ?? ???????';
		PRINT '?????? ??????? TestTable';
		CREATE TABLE TestTable   -- ??????? ??????? ???? ??? ?? ??????????
			(
				Col1 int,
				Col2 varchar(20)
			)
	END   -- ????? ?????
	
ELSE
	BEGIN
		PRINT '??????? TestTable ??????????!'; 
		PRINT '?????? ??????? TestTable';
		DROP TABLE TestTable;
		PRINT '??????? TestTable ???????';
	END;
GO
----------------------------------------------------------------------------
--                            ???????? CASE 
----------------------------------------------------------------------------
-- ??????? ???????? CASE 

DECLARE @myTinyVar TinyInt =3 ;
	
PRINT CASE @myTinyVar          -- ??????? ????????? ??? CASE
		WHEN 0 THEN 'zero'     -- ???? @myIntVar = 0 ?? ??????? 'zero'
		WHEN 1 THEN 'One'      -- ???? @myIntVar = 1 ?? ??????? 'One'
		WHEN 2 THEN 'Two'      -- ???? @myIntVar = 2 ?? ??????? 'Two'
		WHEN 3 THEN 'Three'    -- ???? @myIntVar = 3 ?? ??????? 'Three'
		ELSE 'More than three' -- ???? ?? ????????? ?? ???? ?? ??????? ?? ??????? 'More than three'	
	  END                      --????? ????????? CASE
GO 

----------------------------------------------------------------------------
-- ????????? ???????? CASE 
DECLARE @MyIntVar int;
	
SET @MyIntVar = 0;

PRINT CASE -- ??????????? ??????? ?????????
		WHEN @MyIntVar IS NULL THEN '?????????? @MyIntVar ??????'  -- ????????? ? ??????????? WHEN ?????? ????????? ?????? ????????
		WHEN @MyIntVar < 0 THEN '?????????? @MyIntVar ?????? ????'
		WHEN @MyIntVar > 0 THEN '?????????? @MyIntVar ?????? ????'
		WHEN @MyIntVar > 3 THEN '?????????? @MyIntVar ?????? ????' -- ?????? ?????? ??????? ?? ????? ??????????, ??? ??? ?? ?????????? ?????? ???? ???????? ?? ???????? ?????? ????, ? ????? ???????? ?????? ???? ???? ?????? ????
		ELSE '?????????????? ????????'
	  END
GO

----------------------------------------------------------------------------
-- ???????? WHILE. ??????????? ??????

DECLARE @myVar int;
SET @myVar = 0;

	WHILE (@myVar < 21) -- ??????? ?????????? ?????, ???? ??????? ??????? ??????????? ????.
	BEGIN
		PRINT '??????? ???????? ' + CAST (@myVar as varchar);
		SET @myVar = @myVar + 1;
	END
GO
----------------------------------------------------------------------------

DECLARE @myVar int;
SET @myVar =0;

	WHILE @myVar < 21 
	BEGIN
		PRINT '??????? ???????? ' + CAST (@myVar as varchar);
		IF @myVar =5
			BEGIN
				SET @myVar = @myVar + 2;
				CONTINUE; -- ????????? ?????????? ?????????? ??????? ???????? ? ???????????? ? ?????? ????? WHILE
			END; 
		SET @myVar = @myVar + 1;
	END	
GO	
----------------------------------------------------------------------------

DECLARE @myVar int;
SET @myVar = 0;

	WHILE @myVar < 21 
	BEGIN
		PRINT '??????? ???????? ' + CAST (@myVar as varchar);	
		IF @myVar = 7 
		BEGIN
			PRINT '@myVar = 7! ?????????? ?????!' 
			BREAK; -- ???????? ?????????? ????? (?? ????????????? ????????????)
		END
		SET @myVar = @myVar + 1;
	END	
GO	

----------------------------------------------------------------------------
--------------------------- ???????? WAITFOR -------------------------------

WAITFOR DELAY '00:00:10'; -- ???????? ?? ?????????? ???????. ????????? ????????: ? ?????:???????:????????

PRINT '?????? 10 ??????';

WAITFOR TIME '15:20:20'; -- ???????? ?? ?????????? ???????? ???????. ????????? ????????: ? ?????:???????:????????

PRINT ' ???? ??????????';		
	
----------------------------------------------------------------------------
--------------------------- ????? TRY ? CATCH ------------------------------
-- ????????????? ??? ????????? ??????
 
BEGIN TRY -- ??????? ????????? ???, ???? ????????? ?????? ?? ??????? ?? ? ???? CATCH, ????? ?????????? ?????? ??? ????? CATCH. 

	CREATE TABLE TestTable 
		(
			col1 int,
			col2 varchar(10)	
		);
		
END TRY
BEGIN CATCH -- ???? CATCH - ????-?????????? ??????

	DECLARE @ErrorNo  int,
			@Message  nvarchar(4000);

	SELECT
		@ErrorNo = ERROR_NUMBER(),		--????????? ???????, ?????????? ??? ??????? ??????
		@Message = ERROR_MESSAGE();		--????????? ???????, ?????????? ????????? ??????? ??????

	IF @ErrorNo = 2714
		PRINT '?????? ??????? ??? ??????????!'
	ELSE
		PRINT CAST(@ErrorNo as varchar)+' '+@Message;
END CATCH
GO


----------------------------------------------------------------------------

BEGIN TRY -- ???????? ????????? ???, ???? ????????? ?????? ?? ??????? ?? ? ???? CATCH, ????? ?????????? ?????? ??? ????? CATCH. 
	
	DROP TABLE TestTable;

END TRY

BEGIN CATCH -- ???? CATCH - ????-?????????? ??????

	DECLARE @ErrorNo  int,
			@Message  nvarchar(4000);

	SELECT
		@ErrorNo = ERROR_NUMBER(),		--????????? ???????, ?????????? ??? ??????? ??????
		@Message = ERROR_MESSAGE();		--????????? ???????, ?????????? ????????? ??????? ??????

	IF @ErrorNo = 3701
		PRINT '?????? ??????? ??? ???????!'
	ELSE
		PRINT CAST(@ErrorNo as varchar)+' '+@Message;
END CATCH
GO

----------------------------------------------------------------------------
--                 ????????? ????????? ?? ?????? ??????? 
IF NOT EXISTS (    
				SELECT s.name,t.name
				FROM sys.schemas as s 
				JOIN sys.tables t  
					ON s.schema_id = t.schema_id 
				WHERE s.name = 'dbo' 
					AND t.name = 'TestTable' 
				)
				
	BEGIN   -- ?????? ?????
		PRINT '??????? TestTable ?? ???????';
		PRINT '?????? ??????? TestTable';
		CREATE TABLE TestTable --??????? ??????? ???? ??? ?? ??????????
			(
				Col1 int,
				Col2 varchar(10)
			)
	END   -- ????? ?????
	
ELSE
	BEGIN
		RAISERROR('?????? ??????? ??????????', 11, 238) -- ?????? ???????? ????????????? ? ?????? 
		-- RAISERROR('?????? ??????? ??????????', 11, 238)-- ????? ???????????		
		-- (?????? ???????? RAISERROR - ??????? ?????????? ?????? ? ??????????? ?????????)
		-- RAISERROR (?????? ?????????, ??????? ?????????? ??????, ??????????? ?????????)
		/*??????? ?????????? ?????? - ?????????? ????? ???????? ??????? ????????? ??? ????????????? ??????
		  ??????????? ????????? - ???????????? ????????, ??????????? ? ???? ??????? ????? ????????? ??????, 
		  ???? ? ??? ? ?????????? ?????? ?????????? ??????, ?? ???? ???????? 
		  ???????????? ????????? ????? ?????????? ??? ???????? ? ???? ??????*/
	END;
GO

----------------------------------------------------------------------------