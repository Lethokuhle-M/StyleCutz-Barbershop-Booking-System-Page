using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StyleCutzBarberShopWebApp
{
    public partial class CreateCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Check if the page is being loaded for the first time
            {
                CheckUserRoleAndSetTextBoxes(); // This will now only execute on the first load
            }
        }
        private void CheckUserRoleAndSetTextBoxes()
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

            // Check if the logged-in user is an admin or manager
            if (User.IsInRole("Admin") || adminEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                // Clear the textboxes for admin and manager users
                TextBox5.Text = string.Empty;
                TextBox3.Text = string.Empty;
            }
            else
            {
                // If not admin or manager, set textboxes accordingly
                TextBox5.Text = "N/A";
                TextBox3.Text = userEmail;
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            CheckUserRole();
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

            // Check if the logged-in user is an admin or manager
            if (User.IsInRole("Admin") || adminEmails.Contains(userEmail, StringComparer.OrdinalIgnoreCase))
            {
                SqlDataSource1.Insert();
                ShowModal("Confirmation Message", "Your details have been captured successfully.");
                Response.Redirect("/Private/Admin/SelectCustomer.aspx");
            }
            else
            {
                // Insert user details and display confirmation for non-admin/manager users
                CreateCustomerDS.InsertParameters["customer_email"].DefaultValue = userEmail;
                CreateCustomerDS.Insert();
                ShowModal("Confirmation Message", "Your details have been captured successfully.");
                Response.Redirect("~/");
            }
        }

        private void ShowModal(string title, string message)
        {
            string script = $"$('#modalTitle').text('{title}'); $('#modalBody').text('{message}'); $('#messageModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, true);
        }
    }
}