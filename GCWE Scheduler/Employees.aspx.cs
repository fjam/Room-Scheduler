using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace GCWE_Scheduler
{
    public partial class Employees : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["New"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e) {
            try {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();

                SqlCommand com;
                string query = "INSERT INTO [StaffHours]([FirstName], [LastName], [XT], [Room], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday]) VALUES(@FirstName, @LastName, @XT, @Room, @Monday, @Tuesday, @Wednesday, @Thursday, @Friday)";
                    
                    com = new SqlCommand(query, conn);
                    SqlCommand thisCommand = conn.CreateCommand();

                    com.Parameters.AddWithValue("@FirstName", TextBox1.Text);
                    com.Parameters.AddWithValue("@LastName", TextBox2.Text);
                    com.Parameters.AddWithValue("@XT", TextBox3.Text);
                    com.Parameters.AddWithValue("@Room", TextBox4.Text);
                    com.Parameters.AddWithValue("@Monday", TextBox5.Text);
                    com.Parameters.AddWithValue("@Tuesday", TextBox6.Text);
                    com.Parameters.AddWithValue("@Wednesday", TextBox7.Text);
                    com.Parameters.AddWithValue("@Thursday", TextBox8.Text);
                    com.Parameters.AddWithValue("@Friday", TextBox9.Text);

                    com.ExecuteNonQuery();

                    Response.Write("successful");

                conn.Close();
            }
            catch (Exception ex) {
                Response.Write("error: " + ex.ToString() + "<br/>");
                Response.Write("There seems to be an error, please make sure your times do not conflict with another event.");
            }
        }
    }
}