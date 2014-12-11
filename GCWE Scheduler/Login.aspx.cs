using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


namespace GCWE_Scheduler
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e) {
            Label1.Enabled = false;
            //Calendar1.SelectedDate = Calendar1.TodaysDate;
        }

        protected void Button1_Click(object sender, EventArgs e) {
            if (IsPostBack) {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                string checkuser = "select count(*) from users where username='" + TextBoxUn.Text + "'";
                SqlCommand com = new SqlCommand(checkuser, conn);
                int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
                conn.Close();
                if (temp == 1) {
                    conn.Open();
                    string checkpassQuery = "select pass from users where username = '" + TextBoxUn.Text + "'";
                    SqlCommand passComm = new SqlCommand(checkpassQuery, conn);
                    string password = passComm.ExecuteScalar().ToString().Replace(" ", "");
                    if (password == TextBoxP.Text) {
                        Session["New"] = TextBoxUn.Text;
                        Label1.Enabled = true;
                        Label1.ForeColor = System.Drawing.Color.Green;
                        Label1.Text = "Password is correct";

                        Response.Redirect("Default.aspx");
                    }
                    else {
                        Label1.Enabled = true;
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Text = "Password is incorrect";
                    }
                }
                else {
                    Label1.Enabled = true;
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Username is incorrect";
                }
            }
        }

        private string SwitchColor(string type) {
            string color = "#ffff00";

            switch (type) {
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

        List<string> a = new List<string>();
        List<string> rooms = new List<string>();
        List<string> v = new List<string>();
        Dictionary<int, string> trueRepeatedEvents = new Dictionary<int, string>();

        private void freeTablefunc() {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs)) {
                SqlCommand thisCommand = conn.CreateCommand();
                thisCommand.CommandText = "SELECT title FROM Room";
                conn.Open();
                SqlDataReader reader = thisCommand.ExecuteReader();

                while (reader.Read()) {
                    string room = reader.GetString(0);
                    rooms.Add(room);
                }
            }

            string htmlStr = "";

            Period p = new Period(DateTime.Parse("9:00:00"), DateTime.Parse("22:00:00"));

            var lines = v.ToArray();
            //new[]
            //{  
            //    "Meeting#19:00:00#20:30:00#Conference", 
            //    "Hist 2368#19:00:00#20:30:00#Large Conference Room",
            //    "Hist 2368#09:00:00#10:30:00#Large Conference Room",
            //};

            //lines = lines.Concat(v).ToArray();

            var full_day = new Period(DateTime.Parse("09:00"), DateTime.Parse("22:00"));

            foreach (var s in lines) {
                //System.Diagnostics.Debug.WriteLine(s);
            }

            var free_times =
                from line in lines
                let parts = line.Split('#')
                let Start = DateTime.Parse(parts[2])
                let End = DateTime.Parse(parts[3])
                orderby Start, End
                group new Period(Start, End) by parts[6] into groups
                select new {
                    Room = groups.Key,
                    FreePeriods =
                    groups.Aggregate(new[] { full_day },
                    (ys, x) => ys.SelectMany(y => y.Split(x)).ToArray()),
                };

            foreach (var s in free_times) {
                //System.Diagnostics.Debug.WriteLine(s.Room);
                htmlStr += "<tr><td BGCOLOR='00ff21'>" + s.Room + ":</td></tr>";
                foreach (var fp in s.FreePeriods) {
                    //System.Diagnostics.Debug.WriteLine(fp);
                    htmlStr += "<tr><td BGCOLOR='00ff21'>" + "" + "</td><td>" + fp.StartTime.ToLongTimeString() + "</td><td>" + fp.EndTime.ToLongTimeString() + "</td></tr>";
                }
            }

            foreach (string k in rooms) {
                bool b = false;
                //System.Diagnostics.Debug.WriteLine(k);
                foreach (var l in free_times) {
                    //string[] tk = l.Split('#');
                    if (k == l.Room) {
                        //htmlStr += "<tr><td BGCOLOR= '00ff21'>" + k + ":</td></tr><tr><td BGCOLOR= '00ff21'> </td><td> 9:00:00 AM </td><td> 10:00:00 PM </td></tr>";
                        b = true;
                        //System.Diagnostics.Debug.WriteLine(tk[6]);
                        //break;
                    }
                }
                if (!b) {
                    htmlStr += "<tr><td BGCOLOR= '00ff21'>" + k + ":</td><td> 9:00:00 AM </td><td> 10:00:00 PM </td></tr>";
                }
            }

            //foreach (string s in v) {
            //    string[] seprated = s.Split('#');


            //    htmlStr += "<tr><td>" + s + "</td><tr>";

            //    if (Convert.ToDateTime(seprated[2]) < DateTime.Parse(dayStartTime)) {
            //        System.Diagnostics.Debug.WriteLine("You have entered a time that is eariler than 9:00:00");
            //    }
            //    else if (Convert.ToDateTime(seprated[2]) >= DateTime.Parse(dayStartTime) && Convert.ToDateTime(seprated[2]) <= DateTime.Parse(dayEndTime)) {
            //        //System.Diagnostics.Debug.WriteLine("The time fits in between 9:00:00 and 22:00:00");

            //        //int begHours = Convert.ToInt16(seprated[2]) - Convert.ToInt16(dayStartTime);
            //        int begHours = Convert.ToDateTime(seprated[2]).Hour - DateTime.Parse(dayStartTime).Hour;
            //        int endHours = Convert.ToDateTime(seprated[3]).Hour - DateTime.Parse(dayStartTime).Hour;

            //        DateTime d3 = DateTime.Parse(dayStartTime);
            //        string[] t = seprated[2].Split(':');
            //        d3.AddHours(Convert.ToInt16(t[0]));

            //        System.Diagnostics.Debug.WriteLine("The time fits in between 9:00:00 and 22:00:00 =====    " + t[0] + " sdfdsfs " + begHours);
            //        System.Diagnostics.Debug.WriteLine("FREE TIME IS STARTING FROM: " +
            //            (((dayStartTime[0] + begHours) > dayStartTime[0]) ? "9:00:00" : (((dayStartTime.ToString() == seprated[2])) ? seprated[3].ToString() : "fsdafd") +
            //            " TILL: " + (begHours + Convert.ToInt32(dayStartTime[0])).ToString()));

            //    }
            //}

            freeTable.InnerHtml = htmlStr;
        }

        private void fillList() {
            SqlConnection thisConnection2 = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand thisCommand = thisConnection2.CreateCommand();
            thisCommand.CommandText = "SELECT * from events";
            thisConnection2.Open();
            SqlDataReader reader = thisCommand.ExecuteReader();
            while (reader.Read()) {
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

                a.Add(event_id.ToString() + "#" + title + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString() + "#" + user + "#" + notes + "#" + type + "#" + instructor + "#" + section);
            }
            thisConnection2.Close();
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e) {

            SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            SqlCommand thisCommand = thisConnection.CreateCommand();

            string color = "#ffff00";
            eventTable.InnerHtml = "";
            freeTable.InnerHtml = "";
            string htmlStr1 = "";
            fillList();

            foreach (string s in a) {
                string[] arr = s.Split('#');
                string[] daySplit;

                if (arr[4].ToString() == "1") {
                    trueRepeatedEvents.Add(Convert.ToInt32(arr[0]), arr[5].ToString());
                    thisCommand.CommandText = "SELECT * from events where repeat = 1 AND startDate <= '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                    thisConnection.Open();
                    SqlDataReader reader = thisCommand.ExecuteReader();

                    if (arr[5].Contains(':')) {
                        daySplit = arr[5].Split(':');
                        foreach (string value in daySplit) {
                            if (value == Calendar1.SelectedDate.DayOfWeek.ToString()) {
                                if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate) {
                                    //string htmlStr1 = "";

                                    while (reader.Read()) {
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
                                        
                                        if (!(v.Contains(concat))) {
                                            v.Add(concat);
                                        }

                                        string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";


                                        if ((htmlStr1.Contains(row)) == false) {
                                            htmlStr1 += row;
                                        }
                                        
                                        // htmlStr2 += "<tr><td BGCOLOR='" + color + "'>'";

                                    }
                                    //eventTable.InnerHtml = htmlStr1;
                                }
                            }
                        }
                    }
                    else {
                        if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString()) {
                            if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate) {
                                //string htmlStr1 = "";

                                while (reader.Read()) {
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
                                    if (!(v.Contains(concat))) {
                                        v.Add(concat);
                                    }

                                    string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";


                                    if ((htmlStr1.Contains(row)) == false) {
                                        htmlStr1 += row;

                                    }
                                }
                                //eventTable.InnerHtml = htmlStr1;
                            }
                        }
                    }
                    thisConnection.Close();
                }
                else {
                    //Response.Write(s + "<br/>");
                    ////repeat
                    //Response.Write(arr[4] + "<br/>");
                    ////room
                    //Response.Write(arr[6] + "<br/>");
                    ////event
                    //Response.Write(arr[1] + "<br/>");
                    ////Start Time
                    //Response.Write(arr[2] + "<br/>");
                    ////End Time
                    //Response.Write(arr[3] + "<br/>");
                    ////User
                    //Response.Write(arr[8] + "<br/>");
                    ////Notes
                    //Response.Write(arr[9] + "<br/>");
                    ////Type
                    //Response.Write(arr[10] + "<br/>");

                    //color = SwitchColor(arr[10]);


                    //var htmlStr1 = "";

                    //htmlStr1 += "<tr><td BGCOLOR='" + color + "'>" + arr[6] + "</td><td>" + arr[1] + "</td><td>" + DateTime.Parse(arr[2].ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(arr[3].ToString()).ToLongTimeString() + "</td><td>" + arr[8] + "</td><td>" + arr[9] + "</td></tr>";





                    //string concat = event_id.ToString() + "#" + text + "#" + eventStart.ToString() + "#" + eventEnd.ToString() + "#" + repeat.ToString() + "#" + Days + "#" + room + "#" + startDate.ToString();
                    //if (!(v.Contains(concat))) {
                    //    v.Add(concat);
                    //}






                    //eventTable.InnerHtml += htmlStr1;


                //    //CODE FOR IF REPEAT IS NOT EQUAL TO 1

                    thisCommand.CommandText = "SELECT * from events where repeat = 0 AND startDate = '" + Calendar1.SelectedDate.ToShortDateString() + "' AND endDate >= '" + Calendar1.SelectedDate.ToShortDateString() + "' and charindex('" + Calendar1.SelectedDate.DayOfWeek.ToString() + "', Days) != 0";

                    thisConnection.Open();
                    SqlDataReader reader = thisCommand.ExecuteReader();


                    if (arr[4].ToString() == "0") {
                        if (arr[5].ToString() == Calendar1.SelectedDate.DayOfWeek.ToString()) {
                            if (DateTime.Parse(arr[7]) <= Calendar1.SelectedDate) {
                                //string htmlStr1 = "";

                                while (reader.Read()) {
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

                                    if (!(v.Contains(concat))) {
                                        v.Add(concat);
                                    }

                                    string row = "<tr><td BGCOLOR='" + color + "'>" + room + "</td><td>" + section + "</td><td>" + title + "</td><td>" + DateTime.Parse(eventStart.ToString()).ToLongTimeString() + "</td><td>" + DateTime.Parse(eventEnd.ToString()).ToLongTimeString() + "</td><td>" + instructor + "</td><td>" + notes + "</td></tr>";

                                    if ((htmlStr1.Contains(row)) == false) {
                                        htmlStr1 += row;

                                    }
                                }
                                //eventTable.InnerHtml = htmlStr1;
                            }
                        }
                    }
                    thisConnection.Close();
                }
            }
            eventTable.InnerHtml = htmlStr1;
            //foreach (string c in v) {
            //    System.Diagnostics.Debug.WriteLine(c);
            //}   
            freeTablefunc();
        }

        protected void TextBoxUn_TextChanged(object sender, EventArgs e) {
            Label1.Enabled = false;
        }

        protected void TextBoxP_TextChanged(object sender, EventArgs e) {
            Label1.Enabled = false;
        }

        //protected void Calendar1_DayRender(object sender, DayRenderEventArgs e) {
        //    if (e.Day.Date.DayOfWeek == DayOfWeek.Saturday || e.Day.Date.DayOfWeek == DayOfWeek.Sunday) {
        //        e.Day.IsSelectable = false;
        //        e.Cell.ForeColor = System.Drawing.Color.Gray;
        //    }
        //}
    }
}