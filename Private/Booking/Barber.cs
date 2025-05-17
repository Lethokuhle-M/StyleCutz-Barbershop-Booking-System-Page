using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public class Barber
    {
        public int BarberID { get; set; }
        public string BarberName { get; set; }
        public string BarberCellNo { get; set; }
        public string BarberEmail { get; set; }
        public string BarberGender { get; set; }

        public Barber(int BarberID,string BarberName,string BarberCellNo
            ,string BarberEmail,string BarberGender)
        {
            this.BarberID = BarberID;
            this.BarberName = BarberName;
            this.BarberCellNo = BarberCellNo;
            this.BarberEmail = BarberEmail;
            this.BarberGender = BarberGender;

        }
    }
}