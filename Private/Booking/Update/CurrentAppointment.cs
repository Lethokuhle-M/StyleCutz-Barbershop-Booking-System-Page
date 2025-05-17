using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Booking.Update
{
    public class CurrentAppointment
    {
        public int Appointment_id { get; set; }
        public int employee_id { get; set; }
        public string Appointment_date { get; set; }
        public decimal Payment_Amount{ get; set; }
        public int AppointmentTime_id { get; set; }


        public CurrentAppointment(int Appointment_id,int employee_id,string Appointment_date,
            decimal Payment_Amount, int AppointmentTime_id)
        {
            this.Appointment_id = Appointment_id;
            this.employee_id = employee_id;
            this.Appointment_date = Appointment_date;
            this.Payment_Amount = Payment_Amount;
            this.AppointmentTime_id = AppointmentTime_id;
        }


    }
}