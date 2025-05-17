using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using StyleCutzBarberShopWebApp.Models;
using StyleCutzBarberShopWebApp.Private.Admin.POS;

namespace StyleCutzBarberShopWebApp.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        protected void Page_Load()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            // Enable this after setting up two-factor authentientication
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
                CheckUserRole();

                // Determine the sections to render
                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    CreatePassword.Visible = true;
                    ChangePassword.Visible = false;
                }

                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
               
            }
            //-------------------------------------------------------------
            //CheckUserRole();
        }

        //--------------------------------------------------------
        private void CheckUserRole()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminAndManagerEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager', 'Barber')";

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

            if (User.IsInRole("Barber") || User.IsInRole("Admin") || User.IsInRole("Manager"))
            {
                // Make the Name, Cellphone, and Gender fields visible
                txtName.Visible = true;
                txtCellNumber.Visible = true;
                txtGender.Visible = true;

                // Make the other fields hidden
                txtAddress.Visible = false;
                txtStudentNumber.Visible = false;
                txtDateOfBirth.Visible = false;

                lblName.Visible = true;
                lblCellNumber.Visible = true;
                lblGender.Visible = true;

                lblAddress.Visible = false;
                lblStudentNumber.Visible = false;
                lblDateOfBirth.Visible = false;

                DBConnect1 connect = new DBConnect1();
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                DBConnect1 db = new DBConnect1();
                db.DA.Fill(ds, "Employee_tbl");
                dt = ds.Tables["Employee_tbl"];
                for(int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["employee_email"].ToString() == userEmail)
                    {
                        txtName.Text = dt.Rows[i]["employee_name"].ToString();
                        txtCellNumber.Text= dt.Rows[i]["employee_cellNo"].ToString();
                        txtGender.Text = dt.Rows[i]["empoyee_gender"].ToString();

                    }
                }
            }
            else
            {
                txtName.Visible = true;
                txtCellNumber.Visible = true;
                

                txtAddress.Visible = true;
                txtStudentNumber.Visible = true;
                txtDateOfBirth.Visible = false;
                txtGender.Visible = false;

                lblName.Visible = true;
                lblCellNumber.Visible = true;
                

                lblAddress.Visible = true;
                lblStudentNumber.Visible = true;
                lblDateOfBirth.Visible = false;
                lblGender.Visible = false;

                //DBConnect2 connect = new DBConnect2();
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                DBConnect2 db = new DBConnect2();
                db.DA.Fill(ds, "Customer_tbl");
                dt = ds.Tables["Customer_tbl"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["customer_email"].ToString() == userEmail)
                    {
                        txtName.Text = dt.Rows[i]["customer_name"].ToString();
                        txtCellNumber.Text = dt.Rows[i]["customer_cellNo"].ToString();
                        txtAddress.Text= dt.Rows[i]["customer_address"].ToString();
                        txtStudentNumber.Text= dt.Rows[i]["student_number"].ToString();
                        //txtDateOfBirth.Text= dt.Rows[i]["date_of_birth"].ToString();
                    }
                }
                       
            }
        }

        //--------------------------------------------------------
        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Remove phonenumber from user
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            CheckUserRole1();
        }

        private void CheckUserRole1()
        {
            var userEmail = User.Identity.Name; // Get the currently logged-in user's email
            List<string> adminAndManagerEmails = new List<string>(); // List to hold admin and manager emails

            // Fetch admin and manager emails from the database
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["G7Pmb2024ConnectionString"].ConnectionString;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT employee_email FROM Employee_tbl WHERE employee_position IN ('Admin', 'Manager', 'Barber')";

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

            // Ensure user has one of the allowed roles
            if (User.IsInRole("Barber") || User.IsInRole("Admin") || User.IsInRole("Manager"))
            {

                // Set the parameters for the update
                SqlDataSource2.UpdateParameters["name"].DefaultValue = txtName.Text;
                SqlDataSource2.UpdateParameters["cellNo"].DefaultValue = txtCellNumber.Text;
                SqlDataSource2.UpdateParameters["gender"].DefaultValue = txtGender.Text;
                SqlDataSource2.UpdateParameters["email"].DefaultValue = userEmail;

                SqlDataSource2.Update();
            }
            else
            {
  
                SqlDataSource3.UpdateParameters["customer_name"].DefaultValue = txtName.Text;
                SqlDataSource3.UpdateParameters["customer_cellNo"].DefaultValue = txtCellNumber.Text;
                SqlDataSource3.UpdateParameters["customer_address"].DefaultValue = txtAddress.Text;
                SqlDataSource3.UpdateParameters["student_number"].DefaultValue = txtStudentNumber.Text;
                //SqlDataSource3.UpdateParameters["date_of_birth"].DefaultValue = txtName.Text;
                SqlDataSource3.UpdateParameters["email"].DefaultValue = userEmail;

                SqlDataSource3.Update();
            }
        }

    }
}