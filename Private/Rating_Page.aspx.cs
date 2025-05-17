using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp
{
    public partial class Rating_Page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource2.SelectParameters["customer_email"].DefaultValue = User.Identity.Name.ToString();
           
            DetailsView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["AppId"] = GridView1.SelectedRow.Cells[1].Text;
            Response.Redirect("~/Make_Rating");
        }
    }
}