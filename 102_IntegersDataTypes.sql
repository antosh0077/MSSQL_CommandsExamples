--***************************************************************************
--                       ????? ???? ?????? ? T-SQL
--***************************************************************************

-------------------------------------- Bit ----------------------------------

-- ????? ??? ????? - Bit. ???????? ???????? (0 ??? 1). 
-- ??? ??????? ?????????? ???????? ????????? ?? 0 ? 1, 
-- ??? ???????? ????? ?????? ????????????? ? 1.

PRINT 'Bit';

DECLARE @bit Bit = 0; 
PRINT @bit;

SET @bit = 1;
PRINT @bit;

SET @bit = -4; -- (-4) ????? ?????? ????????????? ? 1.
PRINT @bit;    -- bit = 1

------------------------------------- TinyInt -------------------------------

-- ????? ??? ????? TinyInt. ???????? ???????? ?? 0 ?? 255.

PRINT 'TinyInt';

DECLARE @tinyint TinyInt = 0;
PRINT @tinyint;  

SET @tinyint = 25;
PRINT @tinyint;

SET @tinyint = 256; -- ?????? ??????????: ?????????????? ????????????.
PRINT @tinyint;     -- ???????? ?????????? @tinyint ????????? ???????.

----------------------------------- SmallInt --------------------------------

-- ????? ?? ?????? SmallInt. ???????? ???????? ?? -32 768 ?? 32 767.

PRINT 'SmallInt';

DECLARE @smallint SmallInt = 32767;
PRINT @smallint;

SET @smallint = -32768;
PRINT @smallint;  

 -------------------------------------- Int ----------------------------------
 
 -- ????? ?? ?????? Int. ???????? ???????? ?? -2 147 483 648 ?? 2 147 483 647.
 
PRINT 'Int'

DECLARE @int Int = 2147483647;
PRINT @int;

SET @int = -2147483648;
PRINT @int;  

------------------------------------ BigInt ----------------------------------

-- ????? ?? ?????? BigInt. ???????? ???????? ?? -(2^63) ?? 2^63-1.

PRINT 'Bigint';

DECLARE @bigint Bigint = 9223372036854775807;
PRINT @bigint;

SET @bigint  = -9223372036854775808; 
PRINT @bigint; 

------------------------------------------------------------------------------
