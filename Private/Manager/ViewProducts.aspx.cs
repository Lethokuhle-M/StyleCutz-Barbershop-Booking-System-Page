using StyleCutzBarberShopWebApp.Private.Admin.POS;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class ViewProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int a = 0;
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                Connect1 db = new Connect1();
                db.DA.Fill(ds, "Inventory_tbl");
                dt = ds.Tables["Inventory_tbl"];
                
                string message = "Low Inventory Levels: ";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Convert.ToInt32(dt.Rows[i]["quantityAvailable"]) < 20)
                    {
                        a = 5;
                        string item = dt.Rows[i]["item_name"].ToString();
                        string qty = dt.Rows[i]["quantityAvailable"].ToString();

                        message += item + " only " + qty + " Left!!, ";


                    }
                }
                if (a == 5)
                {
                    message += "Consider Restocking";
                    string script = $"<script type='text/javascript'>alert('{message}');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script);

                }
              

            }
            
        }
        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            if (TextBox1.Text == "")
            {
                GridView1.DataSourceID = SqlDataSource1.ID;
                GridView1.DataBind();

            }
            else
            {
                GridView1.DataSourceID = SqlDataSource2.ID;
                GridView1.DataBind();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text == "")
            {
                GridView1.DataSourceID = SqlDataSource1.ID;
                GridView1.DataBind();

            }
            else
            {
                GridView1.DataSourceID = SqlDataSource2.ID;
                GridView1.DataBind();
            }

        }
    }
}