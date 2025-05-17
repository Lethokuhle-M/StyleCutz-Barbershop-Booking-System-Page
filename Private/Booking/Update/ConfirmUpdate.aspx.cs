using StyleCutzBarberShopWebApp.Private.Admin;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking.Update
{
    public partial class ConfirmUpdate : System.Web.UI.Page
    {
        Barber barber;
        decimal price = 0;
        List<CartItem> cartItems = new List<CartItem>();

        CurrentAppointment curr;
        Customer cust;
        protected void Page_Load(object sender, EventArgs e)
        {
            barber = (Barber)Session["Barber"];
            barberName.Text = barber.BarberName;

            curr = (CurrentAppointment)Session["CurrentAppointment"];

            cust = (Customer)Session["Customer"];
            CheckUserRole();
            
            string stdNumber = DetailsView1.Rows[5].Cells[1].Text;


            cartItems = (List<CartItem>)Session["Cart"];
            for (int i = 0; i < cartItems.Count; i++)
            {
                price += cartItems[i].service_price;
            }
            if (stdNumber != "N/A")
            {
                price = price * 0.85m;
            }

            customerName.Text = DetailsView1.Rows[1].Cells[1].Text;
            amountDue.Text = price.ToString("C2");

            SqlDataSource5.SelectParameters["id"].DefaultValue = curr.Appointment_id.ToString();
            GridView1.DataBind();

        }
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager')"; // Fetch both Admin and Manager emails

                using (var command = new SqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            adminEmails.Add(reader["employee_email"].ToString());
                        }
                    }
                }
            }

            // Check if the logged-in user is an admin
            if (User.IsInRole("Admin"))
            {
                if (cust == null)
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
                else
                {
                    SqlDataSource1.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                    DetailsView1.DataBind();
                }
            }
            else
            {
                // Check if the logged-in user's email is in the list of admin or manager emails
                if (adminEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
                {
                    if (cust == null)
                    {
                        Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                    }
                    else
                    {
                        SqlDataSource1.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                        DetailsView1.DataBind();
                    }
                }
                else
                {
                    // Handle as a regular user
                    SqlDataSource1.SelectParameters["customer_email"].DefaultValue = userEmail;
                    DetailsView1.DataBind();
                }
            }
        }


        protected void appointmentDate_TextChanged(object sender, EventArgs e)
        {

            SqlDataSource2.SelectParameters["barber"].DefaultValue = barber.BarberID.ToString();
            SqlDataSource2.SelectParameters["date"].DefaultValue = appointmentDate.Text;

            SqlDataSource2.DataBind();

        }
        protected void btn1_Click(object sender, EventArgs e)
        {
            SqlDataSource3.UpdateParameters["id"].DefaultValue = barber.BarberID.ToString();
            SqlDataSource3.UpdateParameters["amount"].DefaultValue = amountDue.Text.Substring(1);

            if (appointmentDate.Text == "")
            {
                SqlDataSource3.UpdateParameters["date"].DefaultValue = curr.Appointment_date;
            }
            else
            {
                SqlDataSource3.UpdateParameters["date"].DefaultValue = appointmentDate.Text;
            }
            

            if (availableTimes.Text == "")
            {
                SqlDataSource3.UpdateParameters["time"].DefaultValue = curr.AppointmentTime_id.ToString();
            }
            else
            {
                SqlDataSource3.UpdateParameters["time"].DefaultValue = availableTimes.Text;
            }
            SqlDataSource3.UpdateParameters["app_id"].DefaultValue = curr.Appointment_id.ToString();
            SqlDataSource3.Update();

            string message = "Appointment successfully updated!!";
            string url = "/Private/Booking/Invoice.aspx"; // Replace with your target page URL
            string script = $"<script type='text/javascript'>alert('{message}'); window.location='{url}';</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
        }

        protected void SqlDataSource3_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
        }
        private void ShowModal(string title, string message)
        {
            string script = $"$('#modalTitle').text('{title}'); $('#modalBody').text('{message}'); $('#messageModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, true);
        }

        protected void SqlDataSource3_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            int id = curr.Appointment_id;

            string date;
            string time;

            SqlDataSource6.DeleteParameters["id"].DefaultValue = id.ToString();
            SqlDataSource6.Delete();

            for (int i = 0; i < cartItems.Count; i++)
            {
                SqlDataSource4.InsertParameters["service_id"].DefaultValue = cartItems[i].service_id.ToString();
                SqlDataSource4.InsertParameters["appointment_id"].DefaultValue = id.ToString();
                SqlDataSource4.Insert();
            }
            if (appointmentDate.Text == "")
            {
                date = curr.Appointment_date;
            }
            else
            {
                date = appointmentDate.Text;

            }

            if (availableTimes.Text == "")
            {
                 time = curr.AppointmentTime_id.ToString();
            }
            else
            {
                time = availableTimes.Text;

            }

            ShowModal("Confirmation Message", "Appointment Booked Succesfully !!");
            string t = "";
            if (Convert.ToInt32(time) == 1)
            {
                t = "09:00-09:30";
            }
            else if (Convert.ToInt32(time) == 2)
            {
                t = "09:30-10:00";
            }
            else if (Convert.ToInt32(time) == 3)
            {
                t = "10:00-10:30";
            }
            else if (Convert.ToInt32(time) == 4)
            {
                t = "10:30-11:00";
            }
            else if (Convert.ToInt32(time) == 5)
            {
                t = "11:00-11:30";
            }
            else if (Convert.ToInt32(time) == 6)
            {
                t = "11:30-12:00";
            }
            else if (Convert.ToInt32(time) == 7)
            {
                t = "12:00-12:30";
            }
            else if (Convert.ToInt32(time) == 8)
            {
                t = "12:30-13:00";
            }
            else if (Convert.ToInt32(time) == 9)
            {
                t = "13:00-13:30";
            }
            else if (Convert.ToInt32(time) == 10)
            {
                t = "13:30-14:00";
            }
            else if (Convert.ToInt32(time) == 11)
            {
                t = "14:00-14:30";
            }
            else if (Convert.ToInt32(time) == 12)
            {
                t = "14:30-15:00";
            }
            else if (Convert.ToInt32(time) == 13)
            {
                t = "15:00-15:30";
            }
            else if (Convert.ToInt32(time) == 14)
            {
                t = "15:30-16:00";
            }
            else if (Convert.ToInt32(time) == 15)
            {
                t = "16:00-16:30";
            }
            else if (Convert.ToInt32(time) == 16)
            {
                t = "16:30-17:00";
            }
            else if (Convert.ToInt32(time) == 17)
            {
                t = "17:00-17:30";
            }
            else if (Convert.ToInt32(time) == 18)
            {
                t = "17:30-18:00";
            }
            else if (Convert.ToInt32(time) == 19)
            {
                t = "18:00-18:30";
            }
            else if (Convert.ToInt32(time) == 20)
            {
                t = "18:30-19:00";
            }
            else if (Convert.ToInt32(time) == 21)
            {
                t = "19:00-19:30";
            }
            else if (Convert.ToInt32(time) == 22)
            {
                t = "19:30-20:00";
            }
            Appointment app = new Appointment(DetailsView1.Rows[1].Cells[1].Text, barberName.Text, date,
                t, DetailsView1.Rows[5].Cells[1].Text, amountDue.Text);

            Session["Appointment"] = app;
            Session["NumHairCut"] = null;
            Session["CurrentAppointment"] = null;
            //Session["Customer"] = null;

            Response.Redirect("/Private/Booking/Invoice.aspx");

        }
    }
}