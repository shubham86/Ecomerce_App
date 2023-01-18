using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JericoTransportManagment
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUserName.Focus();

            if (!Page.IsPostBack && Request.Cookies["AdminRole"] != null)
            {
                if (Request.Cookies["AdminRole"].Value == "admin")
                {
                    Response.Redirect("dashboard.aspx", false);
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            loginVerification();
        }

        private void loginVerification()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable dt = new DataTable();

            ListItem lstItem = new ListItem();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_useraccount_verifiyLogin";

                comm.Parameters.AddWithValue("uName", txtUserName.Value);
                comm.Parameters.AddWithValue("pswd", txtPassword.Value);

                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    if (chbxRemember.Checked)
                    {
                        HttpCookie Cookie = new HttpCookie("AdminID");
                        Cookie.Value = dt.Rows[0]["userID"].ToString() == "" ? "0" : dt.Rows[0]["userID"].ToString();
                        Cookie.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie);

                        HttpCookie Cookie1 = new HttpCookie("AdminName");
                        Cookie1.Value = dt.Rows[0]["fullName"].ToString() == "" ? "" : dt.Rows[0]["fullName"].ToString();
                        Cookie1.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie1);

                        HttpCookie Cookie2 = new HttpCookie("AdminRole");
                        Cookie2.Value = dt.Rows[0]["userRole"].ToString() == "" ? "" : dt.Rows[0]["userRole"].ToString();
                        Cookie2.Expires = DateTime.Now.AddDays(15);
                        Response.Cookies.Add(Cookie2);
                    }
                    else
                    {
                        HttpCookie Cookie = new HttpCookie("AdminID");
                        Cookie.Value = dt.Rows[0]["userID"].ToString() == "" ? "0" : dt.Rows[0]["userID"].ToString();
                        Cookie.Expires = DateTime.Now.AddHours(8);
                        Response.Cookies.Add(Cookie);

                        HttpCookie Cookie1 = new HttpCookie("AdminName");
                        Cookie1.Value = dt.Rows[0]["fullName"].ToString() == "" ? "" : dt.Rows[0]["fullName"].ToString();
                        Cookie1.Expires = DateTime.Now.AddHours(8);
                        Response.Cookies.Add(Cookie1);

                        HttpCookie Cookie2 = new HttpCookie("AdminRole");
                        Cookie2.Value = dt.Rows[0]["userRole"].ToString() == "" ? "" : dt.Rows[0]["userRole"].ToString();
                        Cookie2.Expires = DateTime.Now.AddHours(8);
                        Response.Cookies.Add(Cookie2);
                    }

                    if (dt.Rows[0]["userRole"].ToString() == "admin")
                    {
                        Response.Redirect("dashboard.aspx", false);
                    }
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblalert.Text = "User Name or Password is Incorrect. Please try again !!!";
                    txtUserName.Focus();
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblalert.Text = "Error... Please try again !!!";
                txtUserName.Focus();
            }

            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }

                comm.Dispose();
                conn.Dispose();
            }
        }
    }
}