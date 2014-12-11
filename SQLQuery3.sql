Declare @Date char(8) = '20141013'
;
WITH cte as
(
    SELECT * --eventstart, eventend, rooms, startdate
    FROM [dbo].[Events] -- use your table name instead of the VALUES construct
    --(VALUES
    --('09:00:00','12:30:00' ,'7-3', '20140919'),
    --('15:00:00','17:00:00' ,'7-2', '20141013'),
    --('14:00:00','16:00:00' ,'7-3', '20140919')) x(EventStart , EventEnd,Rooms, DayStarts)
), cte_Days_Room AS
-- get a cartesian product for the day specified and all rooms as well as the start and end time to compare against
(
    SELECT y.EventStart,y.EventEnd, x.room,a.StartDate FROM 
    (SELECT @Date StartDate) a
    CROSS JOIN
    (SELECT DISTINCT Room FROM cte)x
    CROSS JOIN
    (SELECT '09:00:00' EventStart,'09:00:00' EventEnd UNION ALL
     SELECT '22:00:00' EventStart,'22:00:00' EventEnd) y        
), cte_1 AS
-- Merge the original data an the "base data"
(
    SELECT * FROM cte WHERE StartDate=@Date
    UNION ALL
    SELECT * FROM cte_Days_Room
), cte_2 as
-- use the ROW_NUMBER() approach to sort the data
(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY DayStarts, Room ORDER BY EventStart) as pos
    FROM cte_1
)
-- final query: self join with an offest of one row, eliminating duplicate rows if a room is booked starting 9:00 or ending 22:00
SELECT c2a.StartDate, c2a.Room , c2a.EventEnd, c2b.EventStart 
FROM cte_2 c2a
INNER JOIN cte_2 c2b on c2a.DayStarts = c2b.StartDate AND c2a.Room =c2b.Rooms AND c2a.pos = c2b.pos -1
WHERE c2a.EventEnd <> c2b.EventStart
ORDER BY c2a.StartDate, c2a.Room




--IF EXISTS(select * from Events where startDate = '9/19/2014' AND room = '7-4' AND '19:00' BETWEEN eventstart AND eventend OR '15:30' BETWEEN eventstart AND EventEnd)
--	select * from room;
--ELSE
--	select * from users;


--IF (EXISTS(
--     SELECT *
--     FROM   Events
--     WHERE  [eventstart] = '9:00'
--     AND    [StartDate] = '9/19/2014'
--     AND    [Room] = '7-4'
--   ))
--BEGIN
--   RAISERROR('Row already exits!', 16, 1);
--   RETURN;
--END;
--ELSE
--BEGIN
--	select * from room;
--   --INSERT INTO Events
--   --       ([Text], [eventStart], [EventEnd], [Repeat], [Days], [Room], [StartDate])
--   --VALUES (@Text, @EventStart, @EventEnd, @Repeat, @Days, @Room, @StartDate);
--END;