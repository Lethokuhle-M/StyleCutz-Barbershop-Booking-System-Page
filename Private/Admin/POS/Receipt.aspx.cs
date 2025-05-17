using StyleCutzBarberShopWebApp.Private.Booking;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Admin.POS
{
    public partial class Receipt : System.Web.UI.Page
    {
        AppointmentReceipt app;
        List<CartItem> items;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Ensure session objects are not null
            app = (AppointmentReceipt)Session["AppointmentReceipt"] as AppointmentReceipt;
            items = (List<CartItem>)Session["AppointmentServices"] as List<CartItem>;

            if (app == null || items == null)
            {
                // Handle missing session data gracefully (redirect or show an error)
                Response.Redirect("~/Error.aspx");
                return;
            }

            // Check if the user is a student
            if (app.StudentNumber == "N/A")
            {
                // Populate standard receipt
                lblClientName.Text = app.CustomerName;
                barber.Text = app.BarberName;
                lblAppointmentDate.Text = app.Date;
                time.Text = app.Time;

                // Display services with formatting
                lblServiceName.Text = FormatServices(items);

                // Display amount and payment method
                Label1.Text = app.Amount;
                Label2.Text = app.Amount;
                lblPaymentMethod.Text = app.PaymentMethod;


                pnlReceipt.Visible = true;
            }
            else
            {
                // Populate student receipt
                Label3.Text = app.CustomerName;
                Label4.Text = app.BarberName;
                Label5.Text = app.Date;
                Label6.Text = app.Time;

                // Display services with formatting
                Label7.Text = FormatServices(items);

                // Display student-specific details
                Label9.Text = app.StudentNumber;
                Label10.Text = "15%"; // Discount or student rate
                Label8.Text = app.Amount;
                Label11.Text = app.Amount;
                lblStudentPaymentMethod.Text = app.PaymentMethod;

                Panel1.Visible = true;
            }
        }

        private string FormatServices(List<CartItem> items)
        {
            StringBuilder formattedServices = new StringBuilder();

            foreach (var item in items)
            {
                formattedServices.AppendLine($"{item.service_name} - {item.service_price:C}"); // Formats price as currency
            }

            return formattedServices.ToString().Replace(Environment.NewLine, "<br/>"); // Converts line breaks to HTML breaks
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            Session["AppointmentReceipt"] = null;
            Session["AppointmentServices"] = null;
            Response.Redirect("~/");

        }
    }
}