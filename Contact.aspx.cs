using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Net;
using System.Net.Mail;

namespace StyleCutzBarberShopWebApp
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            /*string userName = NameTextBox.Text;
            string userEmail = EmailTextBox.Text;
            string userMessage = MessageTextBox.Text;

            // Email configuration
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("info@stylecutz.com");
            mail.To.Add("support@example.com");  // Where the message will go
            mail.Subject = "New Contact Message";
            mail.Body = $"Name: {userName}\nEmail: {userEmail}\nMessage: {userMessage}";

            SmtpClient smtp = new SmtpClient("smtp.gmail.com");  // Use your SMTP server
            smtp.Port = 587;
            smtp.Credentials = new NetworkCredential("your-email@example.com", "your-email-password");
            smtp.EnableSsl = true;

            try
            {
                smtp.Send(mail);
                // Optional: Show a success message
                Response.Write("<script>alert('Message sent successfully');</script>");
            }
            catch (Exception ex)
            {
                // Optional: Show an error message
                Response.Write("<script>alert('Error sending message: " + ex.Message + "');</script>");
            }*/
        }
    }
}