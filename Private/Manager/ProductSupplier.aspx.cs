using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class ProductSupplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            if (TextBox1.Text== "")
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
         protected void btn1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Private/Manager/SelectSupplier");
        }
    }
}