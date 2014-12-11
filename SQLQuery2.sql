INSERT INTO [Events]([Text], [EventStart], [EventEnd], [Repeat], [Days], [room], [StartDate], [User])
 VALUES('HIST 1120', '6:00', '8:00', 0, 'Friday', '8-1', '9/1/2014', 'staff');

 if selectedDate is 

 I want to get all times that an event is not taking place. The start of the day is `9:00:00` and end is `22:00:00`. 

What my database looks like is this:

    Event       EventStart  EventEnd    Days                Rooms   DayStarts
    CISC 3660	09:00:00	12:30:00	Monday	            7-3     9/19/2014	
    MATH 2501	15:00:00	17:00:00	Monday:Wednesday	7-2     10/13/2014	
    CISC 1110	14:00:00	16:00:00	Monday	            7-3     9/19/2014	

I want to get the times that aren't in the database. 

ex. For SelectedDate (9/19/2014) the table should return:

    Room  FreeTimeStart  FreeTimeEnd
    7-3   12:30:00       14:00:00
    7-3   16:00:00       22:00:00

ex2. SelectedDate (10/13/2014):

    Room  FreeTimeStart  FreeTimeEnd
    7-2    9:00:00       15:00:00
    7-2   17:00:00       22:00:00  





	Select room, eventstart, eventend from events  where StartDate = '10/2/2014'