
--IF (EXISTS(
--     SELECT * 
--	 FROM Events 
--	 WHERE ([StartDate] = @StartDate AND [Room] = @Room) 
--	 AND (@EventStart BETWEEN eventstart AND eventend 
--	 OR @EventEnd BETWEEN eventstart AND EventEnd)
--   ))
--	BEGIN
--		RAISERROR('Row already exits!', 16, 1);
--		RETURN;
--	END;
--ELSE
--BEGIN
--   INSERT INTO Events
--          ([Text], [eventStart], [EventEnd], [Repeat], [Days], [Room], [StartDate], [User], [notes])
--   VALUES (@Text, @EventStart, @EventEnd, @Repeat, @Days, @Room, @StartDate, @Users, @notes);
--END;
--select * from events;
--SELECT * FROM events WHERE [repeat] = 1 AND [room] = '7-2' AND [StartDate] <= '10/13/2014' AND charindex('Monday', Days) != 0


SELECT * from events where repeat = 0 AND startDate = '12/17/14' and charindex('wednesday', Days) != 0