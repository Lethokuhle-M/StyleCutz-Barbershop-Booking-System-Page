using StyleCutzBarberShopWebApp.Private.Admin;
using StyleCutzBarberShopWebApp.Private.Admin.POS;
using StyleCutzBarberShopWebApp.Private.Booking.Update;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    
    public partial class BookAppointment : System.Web.UI.Page
    {
        decimal price = 0;
        CurrentAppointment currentApp;
        List<CartItem> cartItems = new List<CartItem>();

        Customer cust;

        protected void Page_Load(object sender, EventArgs e)
        {
            currentApp = (CurrentAppointment)Session["CurrentAppointment"];
            cartItems = (List<CartItem>)Session["Cart"];
            for(int i = 0; i < cartItems.Count; i++)
            {
                price += cartItems[i].service_price;
            }

            cust = (Customer)Session["Customer"];
            CheckUserRole();


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
            if (User.IsInRole("Admin") || User.IsInRole("Manager") || adminAndManagerEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                if (cust != null)
                {
                    SqlDataSource3.SelectParameters["customer_email"].DefaultValue = cust.cust_email;
                    DetailsView1.DataBind();
                }
                else
                {
                    Response.Redirect("/Private/Admin/SelectCustomer.aspx");
                }
            }
            else
            {
                SqlDataSource3.SelectParameters["customer_email"].DefaultValue = userEmail;
                DetailsView1.DataBind();
            }
        }




        protected void btn1_Click(object sender, EventArgs e)
        {
            if(Session["Barber"] != null)
            {
                if(Session["CurrentAppointment"] == null)
                {
                    Response.Redirect("/Private/Booking/ConfirmAppointment.aspx");
                }
                else
                {
                    Response.Redirect("/Private/Booking/Update/ConfirmUpdate.aspx");
                }

            }
            else if(Session["Barber"] == null && Session["CurrentAppointment"] != null)
            {
                
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                DBConnect1 db = new DBConnect1();
                db.DA.Fill(ds, "Employee_tbl");
                dt = ds.Tables["Employee_tbl"];
                Barber barber = null;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (Convert.ToInt32(dt.Rows[i]["employee_id"]) == currentApp.employee_id)
                    {
                       barber = new Barber(Convert.ToInt32(dt.Rows[i]["employee_id"]), dt.Rows[i]["employee_name"].ToString(), dt.Rows[i]["employee_cellNo"].ToString(), dt.Rows[i]["employee_email"].ToString(), dt.Rows[i]["empoyee_gender"].ToString());
                    }

                }
                Session["Barber"] = barber;

                if (Session["Barber"] != null)
                {
                    Response.Redirect("/Private/Booking/Update/ConfirmUpdate.aspx");
                }

            }
            else
            {
                string message = "Cannot proceed without selecting a barber!!";
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
            
        }
        protected void btn2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Private/Booking/SelectServices");
        }

        private void ShowModal(string title, string message)
        {
            string script = $"$('#modalTitle').text('{title}'); $('#modalBody').text('{message}'); $('#messageModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, true);
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                
                Barber barber;

                int employeeId = Convert.ToInt32(e.CommandArgument);

                ListViewDataItem item = (ListViewDataItem)e.Item;

                var lblBarberName = (Label)item.FindControl("lblBarberName");
                var lblBarberCell = (Label)item.FindControl("lblBarberCell");
                var lblBarberEmail = (Label)item.FindControl("lblBarberEmail");
                var lblBarberGender = (Label)item.FindControl("lblBarberGender");

                string bName = lblBarberName?.Text ?? "Unknown Service";
                string bCell = lblBarberCell?.Text ?? "Unknown Service";
                string bEmail = lblBarberEmail?.Text ?? "Unknown Service";
                string bGender = lblBarberGender?.Text ?? "Unknown Service";

                barber = new Barber(employeeId, bName, bCell, bEmail, bGender);

                Session["Barber"] = barber;

                string message = "Barber Selected, "+ bName;
                string script = $"<script type='text/javascript'>alert('{message}');</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script);
            }
        }
    }
}
  