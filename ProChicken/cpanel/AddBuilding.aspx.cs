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
    public partial class AddBuilding : System.Web.UI.Page
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
                if (Request.QueryString["Id"] != null)
                {
                    fetchBuilding();
                }
            }
        }

        private void fetchBuilding()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_fetchBuilding_inForm";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("bID", Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString());

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    txtBuildingName.Text = DT.Rows[0]["buildingName"].ToString();
                    txtStreet.Text = DT.Rows[0]["street"].ToString();
                    txtCity.Text = DT.Rows[0]["city"].ToString();
                    txtPincode.Text = DT.Rows[0]["pincode"].ToString();
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

        public void insertBuilding()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_add";

                comm.Connection = conn;

                comm.Parameters.AddWithValue("bName", txtBuildingName.Text);
                comm.Parameters.AddWithValue("street", txtStreet.Text);
                comm.Parameters.AddWithValue("city", txtCity.Text);
                comm.Parameters.AddWithValue("pincode", txtPincode.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manageBuildings.aspx?action=insert", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Building Add Error !!! Please try again.";
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
                conn.Dispose();
                comm.Dispose();
            }
        }

        public void updateBuilding()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_update";

                comm.Connection = conn;

                comm.Parameters.AddWithValue("bID", Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString());
                comm.Parameters.AddWithValue("bName", txtBuildingName.Text);
                comm.Parameters.AddWithValue("street", txtStreet.Text);
                comm.Parameters.AddWithValue("city", txtCity.Text);
                comm.Parameters.AddWithValue("pincode", txtPincode.Text);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                
                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manageBuildings.aspx?action=update", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Building Add Error !!! Please try again.";
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
                conn.Dispose();
                comm.Dispose();
            }
        }
        
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString()) == "0")
            {
                insertBuilding();
            }
            else
            {
                updateBuilding();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearForm();
            Response.Redirect("manageBuildings.aspx", false);
        }

        private void clearForm()
        {
            txtBuildingName.Text = "";
            txtStreet.Text = "";
            txtCity.Text = "";
            txtPincode.Text = "";
        }
    }
}