using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using StyleCutzBarberShopWebApp.Models;

namespace StyleCutzBarberShopWebApp.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = Email.Text, Email = Email.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                // Initialize the connection to your SQL Server database
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;
                bool emailExists = false;

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Query to check email in Customer_tbl
                    string queryCustomer = "SELECT COUNT(1) FROM Customer_tbl WHERE customer_email = @Email";
                    using (var command = new SqlCommand(queryCustomer, connection))
                    {
                        command.Parameters.AddWithValue("@Email", user.Email);
                        emailExists = Convert.ToInt32(command.ExecuteScalar()) > 0;
                    }

                    // Query to check email in Employee_tbl if not found in Customer_tbl
                    if (!emailExists)
                    {
                        string queryEmployee = "SELECT COUNT(1) FROM Employee_tbl WHERE employee_email = @Email";
                        using (var command = new SqlCommand(queryEmployee, connection))
                        {
                            command.Parameters.AddWithValue("@Email", user.Email);
                            emailExists = Convert.ToInt32(command.ExecuteScalar()) > 0;
                        }
                    }
                }

                // If email is not found in either table, redirect to CreateCustomer.aspx
                if (!emailExists)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    Response.Redirect("~/Private/CreateCustomer.aspx");
                }
                else
                {
                    // Sign in the user if email is found in one of the tables
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    // Redirect to a user page (or dashboard) after successful sign-in
                    Response.Redirect("~/"); // Modify as needed
                }
            }
            else
            {
                // Display error message if the result is not successful
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }

        }
    }
}