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
    public partial class orderReport : System.Web.UI.Page
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
                if (Request.QueryString["action"] == "insert")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Inserted successfully !!!";

                    txtFromDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                    txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                }
                else if (Request.QueryString["action"] == "update")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Updated successfully !!!";

                    txtFromDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                    txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                }
                else if (Request.QueryString["action"] == "delete")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Deleted successfully !!!";

                    txtFromDate.Text = Request.QueryString["fDate"].ToString();
                    txtToDate.Text = Request.QueryString["tDate"].ToString();

                    DateTime today = DateTime.Now;
                    int x = Convert.ToInt32(DateTime.Now.DayOfWeek);
                    var month = new DateTime(today.Year, today.Month, 1);
                    ddlDay.ClearSelection();

                    if (txtFromDate.Text == (DateTime.Now).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("1").Selected = true;
                    }
                    else if (txtFromDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("2").Selected = true;
                    }
                    else if (txtFromDate.Text == DateTime.Now.AddDays(DayOfWeek.Monday - DateTime.Now.DayOfWeek).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("3").Selected = true;
                    }
                    else if (txtFromDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x) - 6).ToString("yyyy-MM-dd") && txtToDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x)).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("7").Selected = true;
                    }
                    else if (txtFromDate.Text == new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("4").Selected = true;
                    }
                    else if (txtFromDate.Text == month.AddMonths(-1).ToString("yyyy-MM-dd") && txtToDate.Text == month.AddDays(-1).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("5").Selected = true;
                    }
                    else
                    {
                        ddlDay.Items.FindByValue("6").Selected = true;
                    }
                }
                else if (Request.QueryString["action"] == "change")
                {
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Status Changed Successfully";
                    
                    txtFromDate.Text = Request.QueryString["fDate"].ToString();
                    txtToDate.Text = Request.QueryString["tDate"].ToString();

                    DateTime today = DateTime.Now;
                    var month = new DateTime(today.Year, today.Month, 1);
                    ddlDay.ClearSelection();

                    if (txtFromDate.Text == (DateTime.Now).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("1").Selected = true;
                    }
                    else if (txtFromDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("2").Selected = true;
                    }
                    else if (txtFromDate.Text == DateTime.Now.AddDays(DayOfWeek.Monday - DateTime.Now.DayOfWeek).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("3").Selected = true;
                    }
                    else if (txtFromDate.Text == new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("4").Selected = true;
                    }
                    else if (txtFromDate.Text == month.AddMonths(-1).ToString("yyyy-MM-dd") && txtToDate.Text == month.AddDays(-1).ToString("yyyy-MM-dd"))
                    {
                        ddlDay.Items.FindByValue("5").Selected = true;
                    }
                    else
                    {
                        ddlDay.Items.FindByValue("6").Selected = true;
                    }
                }
                else {
                    txtFromDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                    txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                }


                txtFromDate.Attributes["max"] = (DateTime.Now).ToString("yyyy-MM-dd");
                txtToDate.Attributes["max"] = (DateTime.Now).ToString("yyyy-MM-dd");

                fetchOrder();

            }
        }


        private void fetchOrder()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_order_fetchInRepeater";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("fromDate",txtFromDate.Text);
                comm.Parameters.AddWithValue("toDate",txtToDate.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptrOrder.DataSource = DT;
                    rptrOrder.DataBind();
                    rptrOrder1.DataSource = DT;
                    rptrOrder1.DataBind();
                }
                else
                {
                    rptrOrder.DataSource = null;
                    rptrOrder.DataBind();
                    rptrOrder1.DataSource = null;
                    rptrOrder1.DataBind();
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
        
        protected void rptrOrder_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            if (e.CommandName == "status")
            {
                try
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandText = "proc_order_changeDeliveryStatus";

                    comm.Connection = conn;
                    comm.Parameters.AddWithValue("oID", e.CommandArgument.ToString());

                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }

                    if (comm.ExecuteNonQuery() > 0)
                    {
                        Response.Redirect("orderReport.aspx?action=change" + "&fDate=" + txtFromDate.Text + "&tDate=" + txtToDate.Text,false);
                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Unable to Change Status...Please try again !!!";
                        return;
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
            else if (e.CommandName == "delete")
            {
                try
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandText = "proc_order_delete";

                    comm.Connection = conn;
                    comm.Parameters.AddWithValue("oID", e.CommandArgument.ToString());

                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }

                    if (comm.ExecuteNonQuery() > 0)
                    {
                        Response.Redirect("orderReport.aspx?action=delete" + "&fDate=" + txtFromDate.Text + "&tDate=" + txtToDate.Text, false);
                    }
                    else
                    {
                        pnlAlert.Attributes.Add("class", "alert alert-danger");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Unable to delete order...Please try again !!!";
                        return;
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

        private int weekdays(int today)
        {
            int days = 0;
            if (today == 1)
            {
                days = 0;
            }
            else if (today == 2)
            {
                return -1;
            }
            else if (today == 3)
            {
                return -2;
            }
            else if (today == 4)
            {
                return -3;
            }
            else if (today == 5)
            {
                return -4;
            }
            else if (today == 6)
            {
                return -5;
            }
            else if (today == 0)
            {
                return -6;
            }
            return days;
        }

        protected void ddlAll_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateTime today = DateTime.Now;

            if (ddlDay.SelectedItem.Value == "1")
            {
                txtFromDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            }
            else if (ddlDay.SelectedItem.Value == "2")
            {
                txtFromDate.Text = (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd");
                txtToDate.Text = (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd");
            }
            else if (ddlDay.SelectedItem.Value == "3")
            {
                txtFromDate.Text = DateTime.Now.AddDays(weekdays(Convert.ToInt32(DateTime.Now.DayOfWeek))).ToString("yyyy-MM-dd");
                txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            }
            else if (ddlDay.SelectedItem.Value == "4")
            {
                txtFromDate.Text = new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd");
                txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            }
            else if (ddlDay.SelectedItem.Value == "5")
            {
                var month = new DateTime(today.Year, today.Month, 1);
                txtFromDate.Text = month.AddMonths(-1).ToString("yyyy-MM-dd");
                txtToDate.Text = month.AddDays(-1).ToString("yyyy-MM-dd");
            }
            else if (ddlDay.SelectedItem.Value == "7")
            {
                int x = Convert.ToInt32(DateTime.Now.DayOfWeek);
                txtFromDate.Text = DateTime.Now.AddDays(-(x == 0 ? 7 : x) - 6).ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Now.AddDays(-(x == 0 ? 7 : x)).ToString("yyyy-MM-dd");
            }

            fetchOrder();
        }

        protected void txtFromDate_TextChanged(object sender, EventArgs e)
        {
            fetchOrder();

            DateTime today = DateTime.Now;
            int x = Convert.ToInt32(DateTime.Now.DayOfWeek);
            var month = new DateTime(today.Year, today.Month, 1);
            ddlDay.ClearSelection();

            if (txtFromDate.Text == (DateTime.Now).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("1").Selected = true;
            }
            else if (txtFromDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("2").Selected = true;
            }
            else if (txtFromDate.Text == DateTime.Now.AddDays(weekdays(Convert.ToInt32(DateTime.Now.DayOfWeek))).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("3").Selected = true;
            }
            else if (txtFromDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x) - 6).ToString("yyyy-MM-dd") && txtToDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x)).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("7").Selected = true;
            }
            else if (txtFromDate.Text == new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("4").Selected = true;
            }
            else if (txtFromDate.Text == month.AddMonths(-1).ToString("yyyy-MM-dd") && txtToDate.Text == month.AddDays(-1).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("5").Selected = true;
            }
            else
            {
                ddlDay.Items.FindByValue("6").Selected = true;
            }
        }

        protected void txtToDate_TextChanged(object sender, EventArgs e)
        {
            fetchOrder();

            int x = Convert.ToInt32(DateTime.Now.DayOfWeek);
            DateTime today = DateTime.Now;
            var month = new DateTime(today.Year, today.Month, 1);
            ddlDay.ClearSelection();

            if (txtFromDate.Text == (DateTime.Now).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("1").Selected = true;
            }
            else if (txtFromDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now.AddDays(-1)).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("2").Selected = true;
            }
            else if (txtFromDate.Text == DateTime.Now.AddDays(DayOfWeek.Monday - DateTime.Now.DayOfWeek).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("3").Selected = true;
            }
            else if (txtFromDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x) - 6).ToString("yyyy-MM-dd") && txtToDate.Text == DateTime.Now.AddDays(-(x == 0 ? 7 : x)).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("7").Selected = true;
            }
            else if (txtFromDate.Text == new DateTime(today.Year, today.Month, 1).ToString("yyyy-MM-dd") && txtToDate.Text == (DateTime.Now).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("4").Selected = true;
            }
            else if (txtFromDate.Text == month.AddMonths(-1).ToString("yyyy-MM-dd") && txtToDate.Text == month.AddDays(-1).ToString("yyyy-MM-dd"))
            {
                ddlDay.Items.FindByValue("5").Selected = true;
            }
            else
            {
                ddlDay.Items.FindByValue("6").Selected = true;
            }
        }

        protected void btnXSL_Click(object sender, System.EventArgs e)
        {
            openXLS();
        }

        private void openXLS()
        {
            WIHO.BHO objBAL = new WIHO.BHO();
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_order_fetchInRepeater";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("fromDate", txtFromDate.Text);
                comm.Parameters.AddWithValue("toDate", txtToDate.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    objBAL.ExportToExcelDT(DT, "Order_Details_" + txtFromDate.Text + "_to_" + txtToDate.Text);
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