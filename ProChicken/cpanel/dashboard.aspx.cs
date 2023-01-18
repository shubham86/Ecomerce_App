using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProChicken.cpanel
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["AdminID"] == null)
            {
                Response.Redirect("Logout.aspx", false);
                return;
            }

            if (!Page.IsPostBack)
            {
                lblTime.Text =  DateTime.Now.ToString("hh:mm tt");
                lblTime1.Text = DateTime.Now.ToString("hh:mm tt");
                fetchDashboardDetails();
            }
        }


        private void fetchDashboardDetails()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_dashboard_details";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("today", DateTime.Now.ToString("yyyy-MM-dd"));

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    lblTotalProduct.Text = DS.Tables[0].Rows[0]["productCount"].ToString();
                    lblTotalBuilding.Text = DS.Tables[0].Rows[0]["buildingCount"].ToString();
                    lblTotalOrders.Text = DS.Tables[0].Rows[0]["todayorderCount"].ToString();
                    lblDeliveredOrder.Text = DS.Tables[0].Rows[0]["yesterdayCompleteOrder"].ToString();
                    lblPendingOrder.Text = DS.Tables[0].Rows[0]["yesterdayPendingOrder"].ToString();
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    rptrOrder.DataSource = DS.Tables[1];
                    rptrOrder.DataBind();
                }
                else
                {
                    rptrOrder.DataSource = null;
                    rptrOrder.DataBind();
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "ERROR !!! Please try after some time";
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