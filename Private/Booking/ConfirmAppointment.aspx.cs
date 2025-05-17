using StyleCutzBarberShopWebApp.Private.Admin;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public partial class ConfirmAppointment : System.Web.UI.Page
    {
        Barber barber;
        decimal price = 0;
        List<CartItem> cartItems = new List<CartItem>();

        Customer cust;
        protected void Page_Load(object sender, EventArgs e)
        {
            barber = (Barber)Session["Barber"];
            barberName.Text = barber.BarberName;
            
            cust = (Customer)Session["Customer"];
            CheckUserRole();
            string stdNumber = DetailsView1.Rows[5].Cells[1].Text;


            cartItems = (List<CartItem>)Session["Cart"];
            for (int i = 0; i < cartItems.Count; i++)
            {
                price += cartItems[i].service_price;
            }
            if(stdNumber != "N/A")
            {
                price = price * 0.85m;
            }

            customerName.Text = DetailsView1.Rows[1].Cells[1].Text;
            amountDue.Text = price.ToString("C2");

        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminAndManagerEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                // Adjust the query to select emails for both Admins and Managers
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager')";

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            adminAndManagerEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }

            // Check if the logged-in user is an admin or manager
            if (User.IsInRole("Admin") || adminAndManagerEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                if (cust != null)
                {
                    SqlDataSource1.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                    DetailsView1.DataBind();
                }
                else
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
            }
            else
            {
                SqlDataSource1.SelectParameters["customer_email"].DefaultValue = userEmail;
                DetailsView1.DataBind();
            }
        }

        protected void btn2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Private/Booking/SelectBarber");
        }
        protected void appointmentDate_TextChanged(object sender, EventArgs e)
        {

            SqlDataSource2.SelectParameters["barber"].DefaultValue = barber.BarberID.ToString();
            SqlDataSource2.SelectParameters["date"].DefaultValue = appointmentDate.Text;
            
            SqlDataSource2.DataBind();

        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            SqlDataSource3.InsertParameters["employeeID"].DefaultValue=barber.BarberID.ToString();
            SqlDataSource3.InsertParameters["amount"].DefaultValue = amountDue.Text.Substring(1);


            SqlDataSource3.Insert();
            //SqlDataSource3.
            //int id =[SqlDataSource3.para;

        }

        protected void SqlDataSource3_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {

            int id =Convert.ToInt32( e.Command.Parameters["@AppointmentID"].Value.ToString());
            BookingPlatformDS.UpdateParameters["id"].DefaultValue = id.ToString();
            BookingPlatformDS.Update();
           
            for (int i = 0; i < cartItems.Count; i++)
            {
                //SqlDataSource4.InsertParameters["appointment_id"].DefaultValue = id.ToString();
               
                SqlDataSource4.InsertParameters["service_id"].DefaultValue = cartItems[i].service_id.ToString();
                SqlDataSource4.InsertParameters["appointment_id"].DefaultValue = id.ToString();
                SqlDataSource4.Insert();

            }
            string t = "";
            if (Convert.ToInt32(availableTimes.Text) == 1)
            {
                t = "09:00-09:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 2)
            {
                t = "09:30-10:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 3)
            {
                t = "10:00-10:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 4)
            {
                t = "10:30-11:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 5)
            {
                t = "11:00-11:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 6)
            {
                t = "11:30-12:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 7)
            {
                t = "12:00-12:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 8)
            {
                t = "12:30-13:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 9)
            {
                t = "13:00-13:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 10)
            {
                t = "13:30-14:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 11)
            {
                t = "14:00-14:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 12)
            {
                t = "14:30-15:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 13)
            {
                t = "15:00-15:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 14)
            {
                t = "15:30-16:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 15)
            {
                t = "16:00-16:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 16)
            {
                t = "16:30-17:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 17)
            {
                t = "17:00-17:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 18)
            {
                t = "17:30-18:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 19)
            {
                t = "18:00-18:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 20)
            {
                t = "18:30-19:00";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 21)
            {
                t = "19:00-19:30";
            }
            else if (Convert.ToInt32(availableTimes.Text) == 22)
            {
                t = "19:30-20:00";
            }
            Appointment app = new Appointment(DetailsView1.Rows[1].Cells[1].Text,barberName.Text,appointmentDate.Text,
                t, DetailsView1.Rows[5].Cells[1].Text,amountDue.Text);

            Session["Appointment"] = app;
            Session["NumHairCut"] = null;
            
            string message = "Appointment successfully booked!!";
            string url = "/Private/Booking/Invoice.aspx"; // Replace with your target page URL
            string script = $"<script type='text/javascript'>alert('{message}'); window.location='{url}';</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
        }
        private void ShowModal(string title, string message)
        {
            string script = $"$('#modalTitle').text('{title}'); $('#modalBody').text('{message}'); $('#messageModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, true);
        }
    }
}