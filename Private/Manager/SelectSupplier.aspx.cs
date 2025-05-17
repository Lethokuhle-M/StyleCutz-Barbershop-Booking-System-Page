using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class SelectSupplier : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource3.SelectParameters["employee_email"].DefaultValue = User.Identity.Name;
            DetailsView2.DataBind();
        }
        protected void ListView2_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int supplierId = Convert.ToInt32(e.CommandArgument);
                Session["SupplierId"] = supplierId;
                Response.Redirect("~/Private/Manager/SelectItems.aspx");
            }
        }

        protected void btn2_Click(object sender, EventArgs e)
        {
            if(Session["SupplierId"] != null)
            {
                Response.Redirect("~/Private/Manager/SelectItems.aspx");
            }
            else
            {
                string message = "Cannot proceed without selecting a Supplier!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            
        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Private/Manager/ProductSupplier");
        }
    }
}
