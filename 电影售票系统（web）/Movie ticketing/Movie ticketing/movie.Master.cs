using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_ticketing
{
    public partial class movie : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bt_login_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}