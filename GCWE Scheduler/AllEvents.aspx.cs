using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GCWE_Scheduler
{
    public partial class AllEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["New"] == null)
             {
                 Response.Redirect("Default.aspx");
             }
        }

    }
}