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
    public partial class manageBuildings : System.Web.UI.Page
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

                fetchActiveBuilding();
            }
        }

        private void fetchActiveBuilding()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_fetchActiveBuilding_inRepeater";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptrBuildings.DataSource = DT;
                    rptrBuildings.DataBind();
                }
                else
                {
                    rptrBuildings.DataSource = null;
                    rptrBuildings.DataBind();
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

        private void fetchInActiveBuilding()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_fetchInActiveBuilding_inRepeater";
                comm.Connection = conn;

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    rptrBuildings.DataSource = DT;
                    rptrBuildings.DataBind();
                }
                else
                {
                    rptrBuildings.DataSource = null;
                    rptrBuildings.DataBind();
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

        protected void ddl_SelectedIndexChange(object sender, System.EventArgs e)
        {
            if (ddlAll.SelectedItem.Value == "1")
            {
                fetchActiveBuilding();
            }
            else
            {
                fetchInActiveBuilding();
            }
        }

        protected void imgbtnadd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddBuilding.aspx", false);
            return;
        }


        protected void rptrBuilding_RowCommand(object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.Connection = conn;

            if (e.CommandName == "edit")
            {
                Response.Redirect("AddBuilding.aspx?Id=" + e.CommandArgument, false);
                return;
            }
            else if (e.CommandName == "delete")
            {
                if (deleteValidation(Convert.ToInt32(e.CommandArgument)))
                {
                    deleteBuilding(Convert.ToInt32(e.CommandArgument));
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-warning");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Unable to delete. Building has some records";
                    return;
                }
            }
            else if (e.CommandName == "status")
            {

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                try
                {
                    comm.CommandText = "proc_building_changeStatus";

                    comm.Parameters.AddWithValue("bID", Convert.ToInt32(e.CommandArgument));

                    if (comm.ExecuteNonQuery() > 0)
                    {
                        fetchActiveBuilding();
                        pnlAlert.Attributes.Add("class", "alert alert-success");
                        pnlAlert.Visible = true;
                        lblAlert.Text = "Status Changed Successfully";
                        return;
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
        }

        private void deleteBuilding(int id)
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_delete";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("bID", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manageBuildings.aspx?action=delete", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Unable to Delete Record...Please try again !!!";
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

        private bool deleteValidation(int id)
        {
            bool _retVal = false;
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_building_deleteValidation";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("buildID", id);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    return false;
                }
                else
                {
                    return true;
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
            return _retVal;
        }
    }
}