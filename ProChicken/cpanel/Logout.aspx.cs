using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JericoTransportManagment
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Page.IsPostBack))
            {
                if (Request.Cookies["AdminName"] != null)
                {
                    Response.Cookies["AdminName"].Expires = DateTime.Now.AddDays(-1);
                }
                if (Request.Cookies["AdminID"] != null)
                {
                    Response.Cookies["AdminID"].Expires = DateTime.Now.AddDays(-1);
                }
                if (Request.Cookies["AdminRole"] != null)
                {
                    Response.Cookies["AdminRole"].Expires = DateTime.Now.AddDays(-1);
                }
                Response.Redirect("Login.aspx", false);
            }
        }
    }
}