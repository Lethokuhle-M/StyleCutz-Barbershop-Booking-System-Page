using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp
{
    public partial class Make_Rating : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource2.SelectParameters["customer_email"].DefaultValue = User.Identity.Name.ToString();
            SqlDataSource3.SelectParameters["Id"].DefaultValue = Session["AppId"].ToString();
            GridView1.DataBind();
            DetailsView1.DataBind();

           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            decimal ney = Convert.ToDecimal(DropDownList1.Text);
            decimal num = ney/10;

            string rating = num.ToString();
            
            SqlDataSource1.UpdateParameters["appointment_id"].DefaultValue = Session["AppId"].ToString();
            SqlDataSource1.UpdateParameters["appointment_rating"].DefaultValue = rating;
          
            SqlDataSource1.Update();
            
        }

        protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect("~/Private/Rating_Page");
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}