using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class CancelOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
         
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string message;
            string script;
            int row = GridView1.SelectedIndex;
            if(row == -1)
            {
                 message = "Select an Order you wish to cancel";
                 script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            else
            {
                orderPaymentDS.Update();
                GridView1.DataBind();
                message = "Order Cancelled!!";
                script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            
        }
    }
}