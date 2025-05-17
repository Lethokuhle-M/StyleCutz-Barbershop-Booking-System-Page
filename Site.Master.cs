using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using StyleCutzBarberShopWebApp.Models;

namespace StyleCutzBarberShopWebApp
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is in the "Admin" or "Manager" role
                posLink.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");

                A1.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                A2.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                A3.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                A4.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");

                //addOptions.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                Li5.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                Li6.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");
                Li7.Visible = Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager");


                Li1.Visible = Context.User.IsInRole("Manager");
                Li2.Visible = Context.User.IsInRole("Manager");
                Li3.Visible = Context.User.IsInRole("Manager");
                Li4.Visible = Context.User.IsInRole("Manager");
                //orderOptions.Visible = Context.User.IsInRole("Manager");


                report.Visible = Context.User.IsInRole("Manager");

                if (Context.User.IsInRole("Barber"))
                {
                    barber1.Visible = false;
                    barber2.Visible = false;
                    barber3.Visible = false;
                    barber4.Visible = false;
                }
                if(Context.User.IsInRole("Admin") || Context.User.IsInRole("Manager"))
                {
                    barber4.Visible = false;
                }
                
            }
            if (Context.User.Identity.IsAuthenticated)
                ddl.Visible = true;
            else
                ddl.Visible = false;
        }
        
        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }
    }

}