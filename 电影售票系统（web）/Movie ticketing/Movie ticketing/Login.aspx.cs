using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tool;

namespace Movie_ticketing
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string js=Alert.show("登录成功", "https://www.baidu.com/");
            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "",js, true);
        }

        protected void Register_Click(object sender, EventArgs e)
        {
            bool f = false;
            if (f)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}