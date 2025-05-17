using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public partial class MakeOrderPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox1.Text = GridView1.SelectedRow.Cells[4].Text;
            TextBox2.Text = GridView1.SelectedRow.Cells[4].Text;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            orderPaymentDS.Update();
            GridView1.DataBind();
            for(int i = 0; i < GridView2.Rows.Count; i++)
            {
                updateInventory.UpdateParameters["quantity"].DefaultValue = GridView2.Rows[i].Cells[3].Text;
                updateInventory.UpdateParameters["id"].DefaultValue = GridView2.Rows[i].Cells[4].Text;
                updateInventory.Update();

            }
            string message = "Order Payement Successful";
            string script = $"<script type='text/javascript'>alert('{message}');</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            TextBox1.Text = "";
            TextBox2.Text = "";
        }
    }
}