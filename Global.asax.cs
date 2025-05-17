using StyleCutzBarberShopWebApp.Private.Booking;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;
using StyleCutzBarberShopWebApp.Models;
using System.Data.SqlClient;
using StyleCutzBarberShopWebApp.Private.Manager;

namespace StyleCutzBarberShopWebApp
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            Database.SetInitializer<ApplicationDbContext>(null); // Disable the default EF initializer

            CreateRolesAndUsers();
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Initialize the Cart session with an empty list at the start of the session
            Session.Add("Cart", new List<CartItem>());
            Session.Add("Barber", null);
            Session.Add("Appointment", null);
            Session.Add("NumHairCut", null);
            Session.Add("CurrentAppointment", null);
            Session.Add("Customer", null);
            Session.Add("cancel", null);
            Session.Add("SupplierId", null);
            Session.Add("CartItem", new List<Items>());
            Session.Add("CartItems", new List<CartProduct>());
            Session.Add("CustId", 0);
            Session.Add("AppId", 0);
            Session.Add("AppointmentReceipt", null);
            Session.Add("AppointmentServices", new List<CartItem>());
            //Session.Add("BarberID", null);
            // Session["cancel"] = false;

        }

        private void CreateRolesAndUsers()
        {
            using (var context = new ApplicationDbContext())
            {
                var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
                var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

                // Ensure the Admin, Manager, and Barber roles exist
                if (!roleManager.RoleExists("Admin"))
                {
                    roleManager.Create(new IdentityRole("Admin"));
                }
                if (!roleManager.RoleExists("Manager"))
                {
                    roleManager.Create(new IdentityRole("Manager"));
                }
                if (!roleManager.RoleExists("Barber"))
                {
                    roleManager.Create(new IdentityRole("Barber"));
                }

                // Fetch user information from SQL Server database
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT employee_email, employee_position FROM Employee_tbl";
                    using (var command = new SqlCommand(query, connection))
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string email = reader["employee_email"].ToString();
                            string position = reader["employee_position"].ToString();

                            // Find the user by email in Identity
                            var user = userManager.FindByEmail(email);
                            if (user != null)
                            {
                                // Assign roles based on employee_position
                                if (position == "Admin" && !userManager.IsInRole(user.Id, "Admin"))
                                {
                                    userManager.AddToRole(user.Id, "Admin");
                                }
                                else if (position == "Manager" && !userManager.IsInRole(user.Id, "Manager"))
                                {
                                    userManager.AddToRole(user.Id, "Manager");
                                }
                                else if (position == "Barber" && !userManager.IsInRole(user.Id, "Barber"))
                                {
                                    userManager.AddToRole(user.Id, "Barber");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
