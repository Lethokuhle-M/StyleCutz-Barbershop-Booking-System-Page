using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Admin
{
    public class Customer
    {
        public string cust_email { get; set; }
        

        public Customer(string cust_email)
        {
            this.cust_email = cust_email;  
        }
    }
}