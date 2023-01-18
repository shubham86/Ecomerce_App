using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProChicken.cpanel
{
    public partial class AddProduct : System.Web.UI.Page
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
                    fetchProduct();
                }
            }
        }

        private void fetchProduct()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();
            MySqlDataAdapter DA = new MySqlDataAdapter();
            DataTable DT = new DataTable();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_product_fetchProduct_inForm";
                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString());

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                DA = new MySqlDataAdapter(comm);
                DA.Fill(DT);

                if (DT.Rows.Count > 0)
                {
                    txtProductName.Text = DT.Rows[0]["productName"].ToString();
                    txtQuantity.Text = DT.Rows[0]["packageQuantity"].ToString();
                    txtPrice.Text = DT.Rows[0]["price"].ToString();

                    lblImg1.ForeColor = DT.Rows[0]["photoName"].ToString() == "empty" ? System.Drawing.Color.White : System.Drawing.Color.Black;
                    lblImg1.Text = DT.Rows[0]["photoName"].ToString();
                    lblOldName1.Text = DT.Rows[0]["photoName"].ToString();
                    Image1.ImageUrl = DT.Rows[0]["photoName"].ToString() == "empty" ? "../images/NoImage.jpg" : DT.Rows[0]["photo"].ToString();
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

        public void insertProduct()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_product_add";

                comm.Connection = conn;

                comm.Parameters.AddWithValue("pName", txtProductName.Text);
                comm.Parameters.AddWithValue("qty", txtQuantity.Text);
                comm.Parameters.AddWithValue("price", txtPrice.Text);

                string imgfile1 = DateTime.Now.ToString("yyyy-MM-dd-hh.mm.ss.ff") + "_1" + System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);//Path.GetFileName(FileUpload1.PostedFile.FileName);

                comm.Parameters.AddWithValue("photoName", Path.GetFileName(FileUpload1.PostedFile.FileName) == "" ? "empty" : imgfile1);
                comm.Parameters.AddWithValue("photo",  "../cpanel/Product_Photos/" + imgfile1);

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (comm.ExecuteNonQuery() > 0)
                {
                    if (Path.GetFileName(FileUpload1.PostedFile.FileName) != "")
                    {
                        FileUpload1.SaveAs(Server.MapPath("../cpanel/Product_Photos/") + imgfile1);
                    }

                    Response.Redirect("manageProduct.aspx?action=insert", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Product Add Error !!! Please try again.";
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

        public void updateProduct()
        {
            MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["CONST_DBCONN"].ConnectionString);
            MySqlCommand comm = new MySqlCommand();

            try
            {
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "proc_product_update";

                comm.Connection = conn;

                comm.Parameters.AddWithValue("pID", Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString());
                comm.Parameters.AddWithValue("pName", txtProductName.Text);
                comm.Parameters.AddWithValue("qty", txtQuantity.Text);
                comm.Parameters.AddWithValue("price", txtPrice.Text);

                string imgfile1 = DateTime.Now.ToString("yyyy-MM-dd-hh.mm.ss.ff") + "_1" + System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);//Path.GetFileName(FileUpload1.PostedFile.FileName);


                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                if (Path.GetFileName(FileUpload1.PostedFile.FileName) != "")
                {
                    //delete recent photo
                    string path = Server.MapPath("../cpanel/Product_Photos/" + lblOldName1.Text);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                    //----------------

                    FileUpload1.SaveAs(Server.MapPath("../cpanel/Product_Photos/") + imgfile1);
                    comm.Parameters.AddWithValue("photoName", imgfile1);
                    comm.Parameters.AddWithValue("photo", "../cpanel/Product_Photos/" + imgfile1);
                }
                else
                {
                    //remove photo
                    if (lblImg1.Text == "empty")
                    {
                        string path = Server.MapPath("../cpanel/Product_Photos/" + lblOldName1.Text);
                        FileInfo file = new FileInfo(path);
                        if (file.Exists)
                        {
                            file.Delete();
                        }
                    }
                    //----------------

                    comm.Parameters.AddWithValue("photoName", lblImg1.Text);
                    comm.Parameters.AddWithValue("photo", "../cpanel/Product_Photos/" + lblImg1.Text);
                }
                               
                if (comm.ExecuteNonQuery() > 0)
                {
                    Response.Redirect("manageProduct.aspx?action=update", false);
                }
                else
                {
                    pnlAlert.Attributes.Add("class", "alert alert-danger");
                    pnlAlert.Visible = true;
                    lblAlert.Text = "Product Add Error !!! Please try again.";
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

        protected void btnDelete1_Click(object sender, System.EventArgs e)
        {
            lblImg1.Text = "empty";
            lblImg1.ForeColor = System.Drawing.Color.White;
            Image1.ImageUrl = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((Request.QueryString["Id"] == null ? "0" : Request.QueryString["Id"].ToString()) == "0")
            {
                insertProduct();
            }
            else
            {
                updateProduct();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearForm();
            Response.Redirect("manageProduct.aspx", false);
        }

        private void clearForm()
        {
            txtProductName.Text = "";
            txtQuantity.Text = "";
            txtPrice.Text = "";
        }
    }
}