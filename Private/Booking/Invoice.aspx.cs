using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public partial class Invoice : System.Web.UI.Page
    {
        Appointment app;
        List<CartItem> items;

        protected void Page_Load(object sender, EventArgs e)
        {
            app = (Appointment)Session["Appointment"];
            items = (List<CartItem>)Session["Cart"];

            if (app.StudentNumber == "N/A")
            {
                //date.Text = DateTime.Now.ToString();
                lblClientName.Text = app.CustomerName;
                barber.Text = app.BarberName;
                lblAppointmentDate.Text = app.Date;
                time.Text = app.Time;
                lblServiceName.Text = "";
                for (int i = 0; i < items.Count; i++)
                {
                    lblServiceName.Text += items[i].service_name + " " + items[i].service_price + "\n";
                }
                Label1.Text = app.Amount;
                Label2.Text = app.Amount;
                

                // Make the panel visible
                pnlReceipt.Visible = true;
            }
            else
            {
                //Label2.Text = DateTime.Now.ToString();
                Label3.Text = app.CustomerName;
                Label4.Text = app.BarberName;
                Label5.Text = app.Date;
                Label6.Text = app.Time;
                
                for (int i = 0; i < items.Count; i++)
                {
                    Label7.Text += items[i].service_name + " " + items[i].service_price + "\n";
                }
                Label9.Text = app.StudentNumber;
                Label10.Text = "15%";
                Label8.Text = app.Amount;
                Label11.Text = app.Amount;
                Label13.Text = ",";

                Panel1.Visible = true;
            }
        }
        protected void btn1_Click(object sender, EventArgs e)
        {

            Session["Cart"] = null;
            Session["Barber"] = null;
            Session["Customer"] = null;

            Response.Redirect("~/Default.aspx");
        }
    }
}