using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Drawing;

namespace GCWE_Scheduler
{
    public partial class Default : System.Web.UI.Page
    {
        private string username = "Unknown";
        private TimeSpan dayStarts = TimeSpan.FromHours(9);
        private TimeSpan dayEnds = TimeSpan.FromHours(22);
        private bool counter = false;

        List<string> a = new List<string>();
        List<string> rooms = new List<string>();
        List<string> v = new List<string>();
        List<string> ex = new List<string>();
        List<string> instr = new List<string>();

        Dictionary<int, string> trueRepeatedEvents = new Dictionary<int, string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["New"] != null)
            {
                Label2.Text = "Welcome: " + Session["New"].ToString();
                username = Session["New"].ToString();
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

            SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            SqlCommand thisCommand = thisConnection.CreateCommand();

            string color = "#ffff00";
            eventTable.InnerHtml = "";
            freeTable.InnerHtml = "";
            string htmlStr1 = "";

            fillList();

            foreach (string s in a)
            {
                string[] arr = s.Split('#');
                string[] daySplit;

                if (arr[4].ToString() == "1")
                {
                    trueRepeatedEvents.Add(Convert.ToInt32(arr[0]), arr[5].ToString());
                    thisCommand.CommandText = "SELECT * from events where repeat = 1 AND startDate <= '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                    thisConnection.Open();
                    SqlDataReader reader = thisCommand.ExecuteReader();

                    if (arr[5].Contains(':'))
                    {
                        daySplit = arr[5].Split(':');
                        foreach (string value in daySplit)
                        {
                            if (value == Calendar1.SelectedDate.DayOfWeek.ToString())
                            {
                                if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                                {

                                    while (reader.Read())
                                    {
                                        int event_id = reader.GetInt32(0);
                                        string title = reader.GetString(1);
                                        TimeSpan eventStart = reader.GetTimeSpan(2);
                                        TimeSpan eventEnd = reader.GetTimeSpan(3);
                                        int repeat = reader.GetInt32(4);
                                        string Days = reader.GetString(5);
                                        string room = reader.GetString(6);
                                        DateTime startDate = reader.GetDateTime(7);
                                        string user = reader.GetString(8);
                                        string notes = reader.GetString(9);
                                        string type = reader.GetString(10);
                                        string instructor = reader.GetString(11);
                                        string section = reader.GetString(12);
                                        DateTime endDate = reader.GetDateTime(13);
                                        color = SwitchColor(type);

                                        string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                        if (!(v.Contains(concat)))
                                        {
                                            v.Add(concat);
                                            ex.Add(concat);
                                        }


                                        string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";


                                        if ((htmlStr1.Contains(row)) == false)
                                        {
                                            htmlStr1 += row;
                                        }

                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString())
                        {
                            if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                            {

                                while (reader.Read())
                                {
                                    int event_id = reader.GetInt32(0);
                                    string title = reader.GetString(1);
                                    TimeSpan eventStart = reader.GetTimeSpan(2);
                                    TimeSpan eventEnd = reader.GetTimeSpan(3);
                                    int repeat = reader.GetInt32(4);
                                    string Days = (reader.GetString(5) == Calendar1.SelectedDate.DayOfWeek.ToString()) ? reader.GetString(5) : "";
                                    string room = reader.GetString(6);
                                    DateTime startDate = reader.GetDateTime(7);
                                    string user = reader.GetString(8);
                                    string notes = reader.GetString(9);
                                    string type = reader.GetString(10);
                                    string instructor = reader.GetString(11);
                                    string section = reader.GetString(12);
                                    DateTime endDate = reader.GetDateTime(13);
                                    color = SwitchColor(type);

                                    string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                    if (!(v.Contains(concat)))
                                    {
                                        v.Add(concat);
                                        ex.Add(concat);
                                    }


                                    string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";


                                    if ((htmlStr1.Contains(row)) == false)
                                    {
                                        htmlStr1 += row;

                                    }
                                }
                            }
                        }
                    }
                    thisConnection.Close();
                }
                else
                {

                    thisCommand.CommandText = "SELECT * from events where repeat = 0 AND startDate = '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                    thisConnection.Open();
                    SqlDataReader reader = thisCommand.ExecuteReader();


                    if (arr[4].ToString() == "0")
                    {
                        if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString())
                        {
                            if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                            {

                                while (reader.Read())
                                {
                                    int event_id = reader.GetInt32(0);
                                    string title = reader.GetString(1);
                                    TimeSpan eventStart = reader.GetTimeSpan(2);
                                    TimeSpan eventEnd = reader.GetTimeSpan(3);
                                    int repeat = reader.GetInt32(4);
                                    string Days = (reader.GetString(5) == Calendar1.SelectedDate.DayOfWeek.ToString()) ? reader.GetString(5) : "";
                                    string room = reader.GetString(6);
                                    DateTime startDate = reader.GetDateTime(7);
                                    string user = reader.GetString(8);
                                    string notes = reader.GetString(9);
                                    string type = reader.GetString(10);
                                    string instructor = reader.GetString(11);
                                    string section = reader.GetString(12);
                                    DateTime endDate = reader.GetDateTime(13);
                                    color = SwitchColor(type);

                                    string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                    if (!(v.Contains(concat)))
                                    {
                                        v.Add(concat);
                                        ex.Add(concat);
                                    }

                                    string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";

                                    if ((htmlStr1.Contains(row)) == false)
                                    {
                                        htmlStr1 += row;

                                    }
                                }
                            }
                        }
                    }
                    thisConnection.Close();
                }
            }
            eventTable.InnerHtml = htmlStr1;
            freeTablefunc();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["New"] = null;
            Response.Redirect("Default.aspx");
        }

        private void freeTablefunc()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand thisCommand = conn.CreateCommand();
                thisCommand.CommandText = "SELECT title FROM Room";
                conn.Open();
                SqlDataReader reader = thisCommand.ExecuteReader();

                while (reader.Read())
                {
                    string room = reader.GetString(0);
                    rooms.Add(room);
                }
            }

            string htmlStr = "";

            Period p = new Period(DateTime.Parse("9:00:00"), DateTime.Parse("22:00:00"));

            var lines = v.ToArray();
            var full_day = new Period(DateTime.Parse("09:00"), DateTime.Parse("22:00"));

            var free_times =
                from line in lines
                let parts = line.Split('#')
                let Start = DateTime.Parse(parts[2])
                let End = DateTime.Parse(parts[3])
                orderby Start, End
                group new Period(Start, End) by parts[6] into groups
                select new
                {
                    Room = groups.Key,
                    FreePeriods =
                    groups.Aggregate(new[] { full_day },
                    (ys, x) => ys.SelectMany(y => y.Split(x)).ToArray()),
                };

            foreach (var s in free_times)
            {
                htmlStr += "<tr><td BGCOLOR='00ff21'>" + s.Room + ":</td></tr>";
                foreach (var fp in s.FreePeriods)
                {
                    htmlStr += "<tr><td BGCOLOR='00ff21'>" + "" + "</td><td>" + fp.StartTime.ToLongTimeString() + "</td><td>" + fp.EndTime.ToLongTimeString() + "</td></tr>";
                }
            }

            foreach (string k in rooms)
            {
                bool b = false;
                foreach (var l in free_times)
                {
                    if (k == l.Room)
                    {
                        b = true;
                    }
                }
                if (!b)
                {
                    htmlStr += "<tr><td BGCOLOR= '00ff21'>" + k + ":</td><td> 9:00:00 AM </td><td> 10:00:00 PM </td></tr>";
                }
            }
            freeTable.InnerHtml = htmlStr;
        }

        public string printTable()
        {
            string htmlStr = "";
            SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand thisCommand = thisConnection.CreateCommand();
            thisCommand.CommandText = "SELECT * from events where startDate='" + Calendar1.SelectedDate.ToString("MM/dd/yyyy") + "'";
            thisConnection.Open();
            SqlDataReader reader = thisCommand.ExecuteReader();
            string color = "#ffff00";
            while (reader.Read())
            {
                int event_id = reader.GetInt32(0);
                string text = reader.GetString(1);
                TimeSpan eventStart = reader.GetTimeSpan(2);
                TimeSpan eventEnd = reader.GetTimeSpan(3);
                int repeat = reader.GetInt32(4);
                string Days = reader.GetString(5);
                string room = reader.GetString(6);
                DateTime startDate = reader.GetDateTime(7);
                string type = reader.GetString(10);
                color = SwitchColor(type);

                htmlStr += "<tr><td BGCOLOR='" + color + "'>" + event_id + "</td><td>" + text + "</td><td>" + eventStart + "</td><td>" + eventEnd + "</td><td>" + repeat + "</td><td>" + Days + "</td><td>" + room + "</td><td>" + startDate + "</td></tr>";
            }
            thisConnection.Close();
            return htmlStr;
        }

        private void fillList()
        {
            SqlConnection thisConnection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand thisCommand = thisConnection2.CreateCommand();
            thisCommand.CommandText = "SELECT * FROM events WHERE endDate >= '" + DateTime.Now.ToString("MM/dd/yyyy") + "'";
            thisConnection2.Open();
            SqlDataReader reader = thisCommand.ExecuteReader();
            while (reader.Read())
            {
                int event_id = reader.GetInt32(0);
                string title = reader.GetString(1);
                TimeSpan eventStart = reader.GetTimeSpan(2);
                TimeSpan eventEnd = reader.GetTimeSpan(3);
                int repeat = reader.GetInt32(4);
                string Days = reader.GetString(5);
                string room = reader.GetString(6);
                DateTime startDate = reader.GetDateTime(7);
                string user = reader.GetString(8);
                string notes = reader.GetString(9);
                string instructor = reader.GetString(11);
                string section = reader.GetString(12);
                DateTime endDate = reader.GetDateTime(13);


                string str = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                if (!(a.Contains(str)))
                {
                    a.Add(event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" +
                        repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + user + "#" + notes);
                }
            }
            thisConnection2.Close();
        }

        private string SwitchColor(string type)
        {
            string color = "#ffff00";

            switch (type)
            {
                case "Class":
                    color = "#ff0000";
                    break;
                case "Meeting":
                    color = "#ffd800";
                    break;
                case "Other":
                    color = "#00ffff";
                    break;
            }

            return color;
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

                conn.Open();

                SqlCommand com;


                string query = "INSERT INTO Events ([Title], [eventStart], [EventEnd],[Repeat], [Days], [Room], [StartDate], [User], [notes], [type], [Instructor], [Section], [EndDate]) VALUES (@Title, @EventStart, @EventEnd, @Repeat, @Days, @Room, @StartDate, @User, @notes, @type, @Instructor, @Section, @EndDate);";

                SqlCommand thisCommands = conn.CreateCommand();
                SqlCommand thisCommand = thisConnection.CreateCommand();

                string color = "#ffff00";
                eventTable.InnerHtml = "";
                freeTable.InnerHtml = "";

                fillList();

                foreach (string s in a)
                {
                    string[] arr = s.Split('#');
                    string[] daySplit;

                    if (arr[4].ToString() == "1")
                    {
                        trueRepeatedEvents.Add(Convert.ToInt32(arr[0]), arr[5].ToString());
                        thisCommand.CommandText = "SELECT * from events where repeat = 1 AND startDate <= '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                        thisConnection.Open();
                        SqlDataReader reader = thisCommand.ExecuteReader();

                        if (arr[5].Contains(':'))
                        {
                            daySplit = arr[5].Split(':');
                            foreach (string value in daySplit)
                            {
                                if (value == Calendar1.SelectedDate.DayOfWeek.ToString())
                                {
                                    if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                                    {
                                        while (reader.Read())
                                        {
                                            int event_id = reader.GetInt32(0);
                                            string title = reader.GetString(1);
                                            TimeSpan eventStart = reader.GetTimeSpan(2);
                                            TimeSpan eventEnd = reader.GetTimeSpan(3);
                                            int repeat = reader.GetInt32(4);
                                            string Days = reader.GetString(5);
                                            string room = reader.GetString(6);
                                            DateTime startDate = reader.GetDateTime(7);
                                            string user = reader.GetString(8);
                                            string notes = reader.GetString(9);
                                            string type = reader.GetString(10);
                                            string instructor = reader.GetString(11);
                                            string section = reader.GetString(12);
                                            DateTime endDate = reader.GetDateTime(13);
                                            color = SwitchColor(type);

                                            string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                            if (!(v.Contains(concat)))
                                            {
                                                v.Add(concat);
                                                ex.Add(concat);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString())
                            {
                                if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                                {
                                    //string htmlStr1 = "";

                                    while (reader.Read())
                                    {
                                        int event_id = reader.GetInt32(0);
                                        string title = reader.GetString(1);
                                        TimeSpan eventStart = reader.GetTimeSpan(2);
                                        TimeSpan eventEnd = reader.GetTimeSpan(3);
                                        int repeat = reader.GetInt32(4);
                                        string Days = (reader.GetString(5) == Calendar1.SelectedDate.DayOfWeek.ToString()) ? reader.GetString(5) : "";
                                        string room = reader.GetString(6);
                                        DateTime startDate = reader.GetDateTime(7);
                                        string user = reader.GetString(8);
                                        string notes = reader.GetString(9);
                                        string type = reader.GetString(10);
                                        string instructor = reader.GetString(11);
                                        string section = reader.GetString(12);
                                        DateTime endDate = reader.GetDateTime(13);
                                        color = SwitchColor(type);

                                        string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                        if (!(v.Contains(concat)))
                                        {
                                            v.Add(concat);
                                            ex.Add(concat);
                                        }

                                    }
                                }
                            }
                        }
                        thisConnection.Close();
                    }
                    else
                    {
                        thisCommand.CommandText = "SELECT * from events where repeat = 0 AND startDate = '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                        thisConnection.Open();
                        SqlDataReader reader = thisCommand.ExecuteReader();


                        if (arr[4].ToString() == "0")
                        {
                            if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString())
                            {
                                if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate)
                                {
                                    while (reader.Read())
                                    {
                                        int event_id = reader.GetInt32(0);
                                        string title = reader.GetString(1);
                                        TimeSpan eventStart = reader.GetTimeSpan(2);
                                        TimeSpan eventEnd = reader.GetTimeSpan(3);
                                        int repeat = reader.GetInt32(4);
                                        string Days = (reader.GetString(5) == Calendar1.SelectedDate.DayOfWeek.ToString()) ? reader.GetString(5) : "";
                                        string room = reader.GetString(6);
                                        DateTime startDate = reader.GetDateTime(7);
                                        string user = reader.GetString(8);
                                        string notes = reader.GetString(9);
                                        string type = reader.GetString(10);
                                        string instructor = reader.GetString(11);
                                        string section = reader.GetString(12);
                                        DateTime endDate = reader.GetDateTime(13);
                                        color = SwitchColor(type);

                                        string concat = event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + endDate.ToString();

                                        if (!(v.Contains(concat)))
                                        {
                                            v.Add(concat);
                                            ex.Add(concat);
                                        }
                                    }
                                }
                            }
                        }
                        thisConnection.Close();
                    }
                }

                foreach (string s in a)
                {
                    string[] arr = s.Split('#');
                    string[] daySplit;

                    if (arr[4].ToString() == "1")
                    {
                        if (arr[5].Contains(':'))
                        {
                            daySplit = arr[5].Split('#');
                            foreach (string day in daySplit)
                            {
                                if (day == Calendar2.SelectedDate.DayOfWeek.ToString())
                                {
                                    if (DateTime.Parse(arr[7]) <= Calendar2.SelectedDate)
                                    {
                                        if (arr[6] == DropDownList1.SelectedValue)
                                        {
                                            if (DateTime.Parse(StartTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                            {
                                                System.Diagnostics.Debug.WriteLine("1 " + s);
                                                counter = true;
                                            }
                                            if (DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse("9:00:00") && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse("22:00:00"))
                                            {
                                                System.Diagnostics.Debug.WriteLine("2 " + s);

                                                counter = true;
                                            }

                                            if (DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                            {
                                                System.Diagnostics.Debug.WriteLine("3 " + s);

                                                counter = true;
                                            }
                                            if (DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[3]))
                                            {
                                                counter = true;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (!(arr[5].Contains(':')))
                        {
                            if (arr[5] == Calendar2.SelectedDate.DayOfWeek.ToString())
                            {
                                if (DateTime.Parse(arr[7]) <= Calendar2.SelectedDate)
                                {
                                    if (arr[6] == DropDownList1.SelectedValue)
                                    {
                                        if (DateTime.Parse(StartTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                        {
                                            System.Diagnostics.Debug.WriteLine("4 " + s);

                                            counter = true;
                                        }
                                        if (DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse("9:00:00") && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse("22:00:00"))
                                        {
                                            System.Diagnostics.Debug.WriteLine("5 " + s);

                                            counter = true;
                                        }

                                        if (DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                        {
                                            System.Diagnostics.Debug.WriteLine("6 " + s);

                                            counter = true;
                                        }
                                        if (DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[3]))
                                        {
                                            counter = true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (arr[4].ToString() == "0")
                    {
                        if (DateTime.Parse(arr[7]) <= Calendar2.SelectedDate)
                        {
                            if (arr[5] == Calendar2.SelectedDate.DayOfWeek.ToString())
                            {

                                if (arr[6] == DropDownList1.SelectedValue)
                                {
                                    System.Diagnostics.Debug.WriteLine(DropDownList1.SelectedValue);
                                    if (DateTime.Parse(StartTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                    {
                                        System.Diagnostics.Debug.WriteLine("7 " + s);

                                        counter = true;
                                    }
                                    if (DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse("9:00:00") && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse("22:00:00"))
                                    {
                                        System.Diagnostics.Debug.WriteLine("8 " + s);

                                        counter = true;
                                    }

                                    if (DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) <= DateTime.Parse(arr[3]))
                                    {
                                        System.Diagnostics.Debug.WriteLine("9 " + s);

                                        counter = true;
                                    }
                                    if (DateTime.Parse(StartTimeTextBox.Text) <= DateTime.Parse(arr[2]) && DateTime.Parse(EndTimeTextBox.Text) >= DateTime.Parse(arr[3]))
                                    {
                                        counter = true;
                                    }
                                }
                            }
                        }
                    }
                }

                if (counter)
                {
                    Response.Write("There was an overlapping error please try again.");
                }
                else if (counter == false)
                {
                    com = new SqlCommand(query, conn);

                    DateTime dt;
                    bool StartRes = DateTime.TryParse(StartTimeTextBox.Text, out dt);
                    bool EndRes = DateTime.TryParse(EndTimeTextBox.Text, out dt);

                    if (StartRes && EndRes)
                    {
                        dt = DateTime.Parse(StartTimeTextBox.Text.ToString());

                        com.Parameters.AddWithValue("@Section", SectionTextBox.Text);
                        com.Parameters.AddWithValue("@Title", EventNameTextBox.Text);
                        com.Parameters.AddWithValue("@EventStart", DateTime.Parse(StartTimeTextBox.Text).ToString("HH:mm:ss"));
                        com.Parameters.AddWithValue("@EventEnd", DateTime.Parse(EndTimeTextBox.Text).ToString("HH:mm:ss"));
                        com.Parameters.AddWithValue("@Repeat", (YesRepeat.Checked) ? 1 : 0);
                        com.Parameters.AddWithValue("@Days", DaysRepeatTextBox.Text);
                        com.Parameters.AddWithValue("@Room", DropDownList1.SelectedValue);
                        com.Parameters.AddWithValue("@StartDate", Calendar2.SelectedDate.ToShortDateString());
                        com.Parameters.AddWithValue("@User", username);
                        com.Parameters.AddWithValue("@notes", NotesTextBox.Text);
                        com.Parameters.AddWithValue("@type", typeDropDownList.SelectedValue);
                        com.Parameters.AddWithValue("@Instructor", InstructorTextBox.Text);
                        com.Parameters.AddWithValue("@EndDate", EndDateTextBox.Text);

                        com.ExecuteNonQuery();

                        Response.Write("successful");
                    }
                    else
                    {
                        Response.Write("Incorrect Time Format");
                    }
                }

                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("error: " + ex.ToString() + "<br/>");
                Response.Write("There seems to be an error, please make sure your times do not conflict with another event.");
            }
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            StartDateTextBox.Text = Calendar2.SelectedDate.ToShortDateString();

            if (DaysRepeatTextBox.Text == "")
            {
                DaysRepeatTextBox.Text += Calendar2.SelectedDate.DayOfWeek.ToString();
            }
            else
            {
                if (!DaysRepeatTextBox.Text.Contains(Calendar2.SelectedDate.DayOfWeek.ToString()))
                {
                    DaysRepeatTextBox.Text += ":" + Calendar2.SelectedDate.DayOfWeek.ToString();
                }
            }
        }

        protected void YesRepeat_CheckedChanged(object sender, EventArgs e)
        {
            if (YesRepeat.Checked)
            {
                DaysRepeatTextBox.Enabled = true;
            }
        }

        protected void Calendar3_SelectionChanged(object sender, EventArgs e)
        {
            EndDateTextBox.Text = Calendar3.SelectedDate.ToShortDateString();

            if (DaysRepeatTextBox.Text == "")
            {
                DaysRepeatTextBox.Text += Calendar3.SelectedDate.DayOfWeek.ToString();
            }
            else
            {
                if (!DaysRepeatTextBox.Text.Contains(Calendar3.SelectedDate.DayOfWeek.ToString()))
                {
                    DaysRepeatTextBox.Text += ":" + Calendar3.SelectedDate.DayOfWeek.ToString();
                }
            }
        }
    }
}