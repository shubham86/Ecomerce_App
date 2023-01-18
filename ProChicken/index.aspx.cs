using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProChicken
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            foreach (RepeaterItem i in rptProducts.Items)
            {
                Label lblPrice = (Label)i.FindControl("lblProductPrice");
                HiddenField hfPrice = (HiddenField)i.FindControl("hfProductPrice");
                lblPrice.Text = hfPrice.Value;
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["order"] != null)
                {
                    if (Request.QueryString["order"].ToString() == "palced")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
                    }
                }

                fetchActiveProduct();
            }
            else
            {
                lblBillTotal.Text = hfBillTotlal.Value;
                lblBillTotal1.Text = hfBillTotlal.Value;
                lblBillTotal2.Text = hfBillTotlal.Value;
                lblBillTotal3.Text = hfBillTotlal.Value;
            }
        }

        private void fetchActiveProduct()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataSet DS = new DataSet();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_product_fetchProduct_and_buildings";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm); 
                DA.Fill(DS);

                if (DS.Tables[0].Rows.Count > 0)
                {
                    rptProducts.DataSource = DS.Tables[0];
                    rptProducts.DataBind();
                }
                else
                {
                    rptProducts.DataSource = null;
                    rptProducts.DataBind();
                }

                ddlBuilding.Items.Clear();

                ListItem lstItem = new ListItem();
                lstItem = new ListItem();
                lstItem.Text = "--- Select Building ---";
                lstItem.Value = "0";
                ddlBuilding.Items.Add(lstItem);

                if (DS.Tables[1].Rows.Count > 0)
                {

                    for (int i = 0; i < DS.Tables[1].Rows.Count; i++)
                    {
                        lstItem = new ListItem();
                        lstItem.Text = DS.Tables[1].Rows[i]["buildingName"].ToString() + " (" + DS.Tables[1].Rows[i]["buildingID"].ToString() + ")";
                        lstItem.Value = DS.Tables[1].Rows[i]["buildingID"].ToString();
                        ddlBuilding.Items.Add(lstItem);
                    }
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "Product could not load! Please try after some time";
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

        protected void calculatePrice(object sender, EventArgs e)
        {
            RepeaterItem item = (sender as Button).NamingContainer as RepeaterItem;

            int qty = Convert.ToInt32((item.FindControl("txtQuantity") as TextBox).Text);
            decimal price = Convert.ToDecimal((item.FindControl("lblPrice") as Label).Text);
            (item.FindControl("lblProductPrice") as Label).Text = (qty * price).ToString();

            decimal cartTotal = 0;
            int cartCount = 0;
            foreach (RepeaterItem i in rptProducts.Items)
            {
                Label box = (Label)i.FindControl("lblProductPrice");
                TextBox box1 = (TextBox)i.FindControl("txtQuantity");
                decimal p = Convert.ToDecimal(box.Text);
                Int32 c = Convert.ToInt32(box1.Text);
                cartTotal += p;
                cartCount += c;
            }

            lblBillTotal.Text = cartTotal.ToString("0.00");
            lblBillTotal1.Text = cartTotal.ToString("0.00");
            lblBillTotal2.Text = cartTotal.ToString("0.00");
            lblBillTotal3.Text = cartTotal.ToString("0.00");
            lblProductCount.Text = cartCount.ToString();

            (item.FindControl("txtQuantity") as TextBox).Focus();
        }

        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string getCustomerDetails(string mobile)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();
            string retval = "";
            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_customer_fetchDetailsByMobile";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("mobileNo", mobile);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    string details = "";

                    details = DT.Rows[0]["customerID"].ToString() + "$" + DT.Rows[0]["name"].ToString() + "$" + DT.Rows[0]["flatNo"].ToString() + "$" + DT.Rows[0]["buildingID"].ToString() + "$" + DT.Rows[0]["buildingName"].ToString();
                    return details;
                }
            }
            catch (Exception ex)
            {
                string x = ex.ToString();
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
            return retval;
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (lblCustomerID.Value == "0")
            {
                insertNewCustomerOrder();
            }
            else
            {
                insertOldCustomerOrder();
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("productName", typeof(string));
            dt.Columns.Add("packageQty", typeof(string));
            dt.Columns.Add("qty", typeof(string));
            dt.Columns.Add("amt", typeof(decimal));

            foreach (RepeaterItem i in rptProducts.Items)
            {
                Label name = (Label)i.FindControl("lblNAme");
                Label pq = (Label)i.FindControl("lblQty");
                TextBox qty = (TextBox)i.FindControl("txtQuantity");
                HiddenField amt = (HiddenField)i.FindControl("hfProductPrice");

                if (qty.Text != "0")
                {
                    DataRow dr = dt.NewRow();
                    dr["productName"] = name.Text;
                    dr["packageQty"] = pq.Text;
                    dr["qty"] = qty.Text;
                    dr["amt"] = amt.Value;
                    dt.Rows.Add(dr);
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowCheckoutPopup();", true);
        }

        private void insertNewCustomerOrder()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            string prodIDstr = "";
            string prodQtystr = "";
            string prodAmtstr = "";

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_order_insertNewCustomer";
                comm.Connection = conn;

                foreach (RepeaterItem i in rptProducts.Items)
                {

                    TextBox qty = (TextBox)i.FindControl("txtQuantity");
                    Label id = (Label)i.FindControl("lblProductID");
                    HiddenField amt = (HiddenField)i.FindControl("hfProductPrice");

                    if (qty.Text != "0")
                    {
                        prodIDstr += (id.Text + ",");
                        prodQtystr += (qty.Text + ",");
                        prodAmtstr += (amt.Value + ",");
                    }
                }

                comm.Parameters.AddWithValue("productIDStr", prodIDstr.Remove(prodIDstr.Length - 1));
                comm.Parameters.AddWithValue("productQtyStr", prodQtystr.Remove(prodQtystr.Length - 1));
                comm.Parameters.AddWithValue("productAmtStr", prodAmtstr.Remove(prodAmtstr.Length - 1));
                comm.Parameters.AddWithValue("oDate", DateTime.Now);
                comm.Parameters.AddWithValue("billAmt", hfBillTotlal.Value);
                comm.Parameters.AddWithValue("payMode", ddlPayMode.SelectedItem.Text);
                comm.Parameters.AddWithValue("transID", "");
                comm.Parameters.AddWithValue("custName", txtName.Text);
                comm.Parameters.AddWithValue("custMobile", txtMobile.Text);
                comm.Parameters.AddWithValue("custFlatNo", txtFlat.Text);
                comm.Parameters.AddWithValue("buildID", ddlBuilding.SelectedItem.Value);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    sendSMS(txtMobile.Text, lblBillTotal.Text);
                    Response.Redirect("index.aspx?order=palced");
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "Order not Placed! Please try after some time";
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

        private void insertOldCustomerOrder()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_order_insertOldCustomer";
                comm.Connection = conn;

                string prodIDstr = "";
                string prodQtystr = "";
                string prodAmtstr = "";
                foreach (RepeaterItem i in rptProducts.Items)
                {

                    TextBox qty = (TextBox)i.FindControl("txtQuantity");
                    Label id = (Label)i.FindControl("lblProductID");
                    HiddenField amt = (HiddenField)i.FindControl("hfProductPrice");

                    if (qty.Text != "0")
                    {
                        prodIDstr += (id.Text + ",");
                        prodQtystr += (qty.Text + ",");
                        prodAmtstr += (amt.Value + ",");
                    }
                }

                comm.Parameters.AddWithValue("productIDStr", prodIDstr.Remove(prodIDstr.Length - 1));
                comm.Parameters.AddWithValue("productQtyStr", prodQtystr.Remove(prodQtystr.Length - 1));
                comm.Parameters.AddWithValue("productAmtStr", prodAmtstr.Remove(prodAmtstr.Length - 1));
                comm.Parameters.AddWithValue("oDate", DateTime.Now);
                comm.Parameters.AddWithValue("billAmt", hfBillTotlal.Value);
                comm.Parameters.AddWithValue("payMode", ddlPayMode.SelectedItem.Text);
                comm.Parameters.AddWithValue("transID", "");
                comm.Parameters.AddWithValue("custID", lblCustomerID.Value);
                comm.Parameters.AddWithValue("flat", txtFlat.Text);
                comm.Parameters.AddWithValue("buildID", ddlBuilding.SelectedItem.Value);

                if (txtFlat.Text != lblOldFlat.Text || ddlBuilding.SelectedItem.Value != lblOldBuilding.Text)
                {
                    comm.Parameters.AddWithValue("isUpdate", 1);
                }
                else
                {
                    comm.Parameters.AddWithValue("isUpdate", 0);
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    sendSMS(txtMobile.Text, lblBillTotal.Text);
                    Response.Redirect("index.aspx?order=palced");
                }

            }
            catch (Exception ex)
            {
                string x = ex.ToString();
                pnlAlert.Attributes.Add("class", "alert alert-danger");
                pnlAlert.Visible = true;
                lblAlert.Text = "Order not Placed! Please try after some time";
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

        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        private void sendSMS(string mobile, string billAmt)
        {
            string user = "ProfeedA";
            //Your authentication key
            string key = "16f9aa9630XX";
            //Sender ID,While using route4 sender id should be 6 characters long.
            string senderid = "alerts";
            //Your message to send, Add URL encoding here.
            string message = "Thanks for your valuable order worth Rs." + lblBillTotal.Text + " %26 will be shipped shortly. Profeed %26 Premix Pvt Ltd (ProEggs %26 ProChicken)";

            //Prepare you post parameters
            String sbPostData = "user=" + user + "&key=" + key + "&mobile=" + mobile + "&message=" + message + "&senderid=" + senderid + "&accusage=1";

            //Call Send SMS API
            string sendSMSUri = "http://mobicomm.dove-sms.com/submitsms.jsp?";
            //Create HTTPWebrequest
            HttpWebRequest httpWReq = (HttpWebRequest)WebRequest.Create(sendSMSUri);
            //Prepare and Add URL Encoded data
            UTF8Encoding encoding = new UTF8Encoding();
            byte[] data = encoding.GetBytes(sbPostData.ToString());
            //Specify post method
            httpWReq.Method = "POST";
            httpWReq.ContentType = "application/x-www-form-urlencoded";
            httpWReq.ContentLength = data.Length;
            using (Stream stream = httpWReq.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            //Get the response
            HttpWebResponse response = (HttpWebResponse)httpWReq.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string responseString = reader.ReadToEnd();

            //Close the response
            reader.Close();
            response.Close();
        }
    }
}