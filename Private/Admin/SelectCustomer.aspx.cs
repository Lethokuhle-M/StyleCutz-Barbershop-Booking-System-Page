using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Admin
{
    public partial class SelectCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cancelCookie = Request.Cookies["cancelClicked"];
            HttpCookie updateCookie = Request.Cookies["updateClicked"];
            if (cancelCookie != null && cancelCookie.Value == "true")
            {
                btn1.Visible = false;
            }
            else if(updateCookie != null && updateCookie.Value == "true")
            {
                btn1.Visible = false;
            }
            

        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Private/CreateCustomer.aspx");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Customer customer = new Customer(GridView1.SelectedRow.Cells[5].Text);
            Session["Customer"] = customer;

            HttpCookie cancelCookie = Request.Cookies["cancelClicked"];
            HttpCookie updateCookie = Request.Cookies["updateClicked"];
            HttpCookie bookAppointmentCookie = Request.Cookies["bookAppointmentClicked"];

            if (cancelCookie != null && cancelCookie.Value == "true")
            {
                Response.Cookies["cancelClicked"].Expires = DateTime.Now.AddDays(-1); // Clear the cookie
                Response.Redirect("~/Private/Booking/CancelAppointment");
            }
            else if (updateCookie != null && updateCookie.Value == "true")
            {
                Response.Cookies["updateClicked"].Expires = DateTime.Now.AddDays(-1); // Clear the cookie
                Response.Redirect("~/Private/Booking/Update/UpdateAppointment");
            }
            else
            {
                btn1.Visible = true;
                Response.Redirect("/Private/Booking/SelectServices.aspx");
            }
        }


        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            if(TextBox1.Text == "")
            {
                GridView1.DataSourceID = SqlDataSource2.ID;
                GridView1.DataBind();
            }
            else
            {
                SqlDataSource3.SelectParameters["Cust"].DefaultValue = TextBox1.Text;
                GridView1.DataSourceID = SqlDataSource3.ID;
                GridView1.DataBind();
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
            SqlDataSource3.SelectParameters["Cust"].DefaultValue = TextBox1.Text;
            GridView1.DataSourceID = SqlDataSource3.ID;
            GridView1.DataBind();

        }
    }
}