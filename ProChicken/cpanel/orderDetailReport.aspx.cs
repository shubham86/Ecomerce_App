using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProChicken.cpanel
{
    public partial class orderDetailReport : System.Web.UI.Page
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
                    //MessageBox("Record Inserted successfully !!!");
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Inserted successfully !!!";
                }
                else if (Request.QueryString["action"] == "update")
                {
                    //MessageBox("Record Updated successfully !!!");
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Updated successfully !!!";
                }
                else if (Request.QueryString["action"] == "delete")
                {
                    //MessageBox("Record Updated successfully !!!");
                    pnlAlert.Attributes.Add("class", "alert alert-success");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Record Deleted successfully !!!";
                }


                txtFromDate.Attributes["max"] = (DateTime.Now).ToString("yyyy-MM-dd");
                txtToDate.Attributes["max"] = (DateTime.Now).ToString("yyyy-MM-dd");
                txtFromDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
                txtToDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");

                fetchOrder();

            }
        }


        private void fetchOrder()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_orderproducts_fetchOrderWise";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("fromDate", txtFromDate.Text);
                comm.Parameters.AddWithValue("toDate", txtToDate.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptrOrder.DataSource = DS.Tables[0];
                    rptrOrder.DataBind();
                    rptrOrder1.DataSource = DS.Tables[0];
                    rptrOrder1.DataBind();
                }
                else
                {
                    rptrOrder.DataSource = null;
                    rptrOrder.DataBind();
                    rptrOrder1.DataSource = null;
                    rptrOrder1.DataBind();
                }

                if (DS.Tables[1].Rows.Count > 0)
                {
                    lblTotalProducts.Text = DS.Tables[1].Rows[0]["productCount"].ToString().Replace(",", "</br>");
                    lblBillTotal.Text = DS.Tables[1].Rows[0]["billTotal"].ToString();
                    lblTotalProducts1.Text = DS.Tables[1].Rows[0]["productCount"].ToString().Replace(",", "</br>");
                    lblBillTotal1.Text = DS.Tables[1].Rows[0]["billTotal"].ToString();
                }
                else {
                    lblTotalProducts.Text = "";
                    lblBillTotal.Text = "0.00";
                    lblTotalProducts1.Text = "";
                    lblBillTotal1.Text = "0.00";
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
        
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            string path = "C:/Users/giram/Downloads/Order_Details_" + txtFromDate.Text + "_to_" + txtToDate.Text + ".xls";
            if (File.Exists(path))
            {
                File.Delete(path);
            }
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "tableToExcel('printTable', 'Order Details Report');", true);
        }

        protected void btnMail_Click(object sender, EventArgs e)
        {
            string filename = "Order_Details_" + txtFromDate.Text + "_to_" + txtToDate.Text + ".xls";
            string path = "C:/Users/giram/Downloads/" + filename;
            if (File.Exists(path))
            {
                SendMail(filename);
            }
            else
            {
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "Excel Report is not downloaded. Try after downloading";
            }
            //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "tableToExcel('printTable', 'Order Details Report');", true);

            
        }

        private void SendMail(string filename)
        {
            string SMTPServerName = ConfigurationManager.AppSettings["SMTPServerName"].ToString();
            string SMTPUser = ConfigurationManager.AppSettings["SMTPUser"].ToString();
            string SMTPPassword = "shubham@94";//ConfigurationManager.AppSettings["SMTPPassword"].ToString();
            string strMessage = string.Empty;
            try
            {
                strMessage = strMessage + "<table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"1\" style=\"FONT-SIZE: 9pt; COLOR: black; DIRECTION: ltr; LINE-HEIGHT: 12pt; FONT-FAMILY: Arial; LETTER-SPACING: normal; TEXT-ALIGN: justify\">";
                strMessage = strMessage + "<tr><td>Prochicken Order Report from "+ txtFromDate.Text + "to" + txtToDate.Text + "</td></tr>";
                strMessage = strMessage + "<tr><td>PFA</td></tr>";
                strMessage = strMessage + "</table>";

                MailMessage mm = new MailMessage();
                mm.IsBodyHtml = true;
                mm.From = new MailAddress(ConfigurationManager.AppSettings["CONST_MAIL_SIGNUP_FROM"].ToString());
                mm.To.Add(new MailAddress(ConfigurationManager.AppSettings["AdminEmail"].ToString()));
                mm.Subject = "Prochicken Order Report";
                mm.Body = strMessage.ToString();

                System.Net.Mail.Attachment attachment;
                attachment = new System.Net.Mail.Attachment("C:/Users/giram/Downloads/Order_Details_" + txtFromDate.Text + "_to_" + txtToDate.Text + ".xls");
                mm.Attachments.Add(attachment);

                SmtpClient mSmtpClient = new SmtpClient();
                mSmtpClient.EnableSsl = true;
                mSmtpClient.Host = SMTPServerName;
                mSmtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["SMTP_Port"]);
                mSmtpClient.UseDefaultCredentials = true;
                mSmtpClient.Credentials = new System.Net.NetworkCredential(SMTPUser, SMTPPassword);
                mSmtpClient.Send(mm);
            }
            catch (Exception ex)
            {
                String x = ex.ToString();
            }
        }
    }
}