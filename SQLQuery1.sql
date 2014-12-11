﻿-----select * from Events where eventstart NOT BETWEEN eventstart AND eventend;


----INSERT INTO [Events]([Text], [EventStart], [EventEnd], [Repeat], [Days], [room], [StartDate], [User])
-- --VALUES('HIST 1120', 
--	if((select * from Events where startDate = '9/19/2014' AND eventstart NOT BETWEEN eventstart AND eventend AND EventEnd NOT BETWEEN eventstart AND EventEnd) >= 1) 
--	BEGIN  
--		PRINT 'HI'
--	END
--	ELSE
--		PRINT 'BYE'
 
-- --, '8:00', 0, 'Friday', '8-1', '9/1/2014', 'staff');

IF EXISTS(select * from Events where startDate = '9/19/2014' AND eventstart NOT BETWEEN eventstart AND eventend AND EventEnd NOT BETWEEN eventstart AND EventEnd) select * from room

-----Create table Temp (room, 

--DECLARE @Events TABLE (Event varchar(20), EventStart Time, EventEnd Time, Days varchar(50), Rooms varchar(10), DayStarts date)

--INSERT INTO @Events
--SELECT 'CISC 3660',   '09:00:00',    '12:30:00',    'Monday',              '7-3',     '9/19/2014' UNION
--SELECT 'MATH 2501',   '15:00:00',    '17:00:00',    'Monday:Wednesday',    '7-2',     '10/13/2014' UNION
--SELECT 'CISC 1110',   '14:00:00',    '16:00:00',    'Monday',              '7-3',     '9/19/2014' 

--DECLARE @Rooms TABLE (RoomName varchar(10))
--INSERT INTO @Rooms
--SELECT '7-2' UNION 
--SELECT '7-3'

--DECLARE @SelectedDate date = '9/19/2014'
--DECLARE @MinTimeInterval int = 30 --smallest time unit room can be reserved for
--;WITH
--  D1(N) AS (
--            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
--            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL
--            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
--           ),
--  D2(N) AS (SELECT 1 FROM D1 a, D1 b),
--  D4(N) AS (SELECT 1 FROM D2 a, D2 b),
--  Numbers AS (SELECT TOP 3600 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) -1 AS Number FROM D4),
--  AllTimes AS 
--    (SELECT CAST(DATEADD(n,Numbers.Number*@MinTimeInterval,'09:00:00') as time) AS m FROM Numbers
--    WHERE DATEADD(n,Numbers.Number*@MinTimeInterval,'09:00:00') <= '22:00:00'),
--  OccupiedTimes AS (
--    SELECT e.Rooms, ValidTimes.m
--    FROM @Events E
--    CROSS APPLY (SELECT m FROM AllTimes WHERE m BETWEEN CASE WHEN e.EventStart = '09:00:00' THEN e.EventStart ELSE DATEADD(n,1,e.EventStart) END and CASE WHEN e.EventEnd = '22:00:00' THEN e.EventEnd ELSE DATEADD(n,-1,e.EventEnd) END) ValidTimes
--    WHERE e.DayStarts = @SelectedDate
--    ),
--    AllRoomsAllTimes AS (
--        SELECT * FROM @Rooms R CROSS JOIN AllTimes
--    ), AllOpenTimes AS (
--    SELECT a.*, ROW_NUMBER() OVER( PARTITION BY (a.RoomName) ORDER BY a.m) AS pos
--    FROM AllRoomsAllTimes A
--    LEFT OUTER JOIN OccupiedTimes o ON a.RoomName = o.Rooms AND a.m = o.m
--    WHERE o.m IS NULL
--    ), Finalize AS (
--    SELECT a1.RoomName,
--        CASE WHEN a3.m IS NULL OR  DATEDIFF(n,a3.m, a1.m) > @MinTimeInterval THEN a1.m else NULL END AS FreeTimeStart,
--        CASE WHEN a2.m IS NULL OR DATEDIFF(n,a1.m,a2.m) > @MinTimeInterval THEN A1.m ELSE NULL END AS FreeTimeEnd,
--        ROW_NUMBER() OVER( ORDER BY a1.RoomName )  AS Pos
--    FROM AllOpenTimes A1
--    LEFT OUTER JOIN AllOpenTimes A2 ON a1.RoomName = a2.RoomName and a1.pos = a2.pos-1
--    LEFT OUTER JOIN AllOpenTimes A3 ON a1.RoomName = a3.RoomName and a1.pos = a3.pos+1
--    WHERE A2.m IS NULL OR DATEDIFF(n,a1.m,a2.m) > @MinTimeInterval
--    OR
--    A3.m IS NULL OR DATEDIFF(n,a3.m, a1.m) > @MinTimeInterval
--    )
--    SELECT F1.RoomName, f1.FreeTimeStart, f2.FreeTimeEnd FROM Finalize F1
--    LEFT OUTER JOIN Finalize F2 ON F1.Pos = F2.pos-1 AND f1.RoomName = f2.RoomName
--    WHERE f1.pos % 2 = 1
select * from dbo.[Events];
--Declare @Date char(8) = '20141013'
--;
--WITH cte as
--(
--    SELECT * --eventstart, eventend, rooms, startdate
--    FROM [dbo].[Events] -- use your table name instead of the VALUES construct
--    --(VALUES
--    --('09:00:00','12:30:00' ,'7-3', '20140919'),
--    --('15:00:00','17:00:00' ,'7-2', '20141013'),
--    --('14:00:00','16:00:00' ,'7-3', '20140919')) x(EventStart , EventEnd,Rooms, DayStarts)
--), cte_Days_Rooms AS
---- get a cartesian product for the day specified and all rooms as well as the start and end time to compare against
--(
--    SELECT y.EventStart,y.EventEnd, x.rooms,a.DayStarts FROM 
--    (SELECT @Date DayStarts) a
--    CROSS JOIN
--    (SELECT DISTINCT Rooms FROM cte)x
--    CROSS JOIN
--    (SELECT '09:00:00' EventStart,'09:00:00' EventEnd UNION ALL
--     SELECT '22:00:00' EventStart,'22:00:00' EventEnd) y        
--), cte_1 AS
---- Merge the original data an the "base data"
--(
--    SELECT * FROM cte WHERE DayStarts=@Date
--    UNION ALL
--    SELECT * FROM cte_Days_Rooms
--), cte_2 as
---- use the ROW_NUMBER() approach to sort the data
--(
--    SELECT *, ROW_NUMBER() OVER(PARTITION BY DayStarts, Rooms ORDER BY EventStart) as pos
--    FROM cte_1
--)
---- final query: self join with an offest of one row, eliminating duplicate rows if a room is booked starting 9:00 or ending 22:00
--SELECT c2a.DayStarts, c2a.Rooms , c2a.EventEnd, c2b.EventStart 
--FROM cte_2 c2a
--INNER JOIN cte_2 c2b on c2a.DayStarts = c2b.DayStarts AND c2a.Rooms =c2b.Rooms AND c2a.pos = c2b.pos -1
--WHERE c2a.EventEnd <> c2b.EventStart
--ORDER BY c2a.DayStarts, c2a.Rooms