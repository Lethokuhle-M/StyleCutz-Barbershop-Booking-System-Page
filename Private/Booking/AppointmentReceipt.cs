using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public class AppointmentReceipt
    {
        public string CustomerName { get; set; }
        public string BarberName { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public string StudentNumber { get; set; }
        public string Amount { get; set; }
        public string PaymentMethod { get; set; }


        public AppointmentReceipt(string c, string b, string d, string t, string s, string a,string p)
        {
            CustomerName = c;
            BarberName = b;
            Date = d;
            Time = t;
            StudentNumber = s;
            Amount = a;
            PaymentMethod = p;
        }
    }
}