using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public class Appointment
    {
        public string CustomerName { get; set; }
        public string BarberName { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public string StudentNumber { get; set; }
        public string Amount { get; set; }

        public Appointment(string c,string b,string d,string t,string s,string a)
        {
            CustomerName = c;
            BarberName = b;
            Date = d;
            Time = t;
            StudentNumber = s;
            Amount = a;
        }
    }
}