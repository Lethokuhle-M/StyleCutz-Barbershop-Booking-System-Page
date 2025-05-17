using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Booking
{
    public class CartItem
    {
        public int service_id { get; set; }
        public string service_name { get; set; }
        public decimal service_price { get; set; }

        public CartItem(int service_id, string service_name, decimal service_price)
        {
            this.service_id = service_id;
            this.service_name = service_name;
            this.service_price = service_price;
        }

    }
}