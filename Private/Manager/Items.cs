using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public class Items
    {

        public int item_id { get; set; }
        public string item_name { get; set; }
        public decimal item_price { get; set; }

        public Items(int item_id, string item_name, decimal item_price)
        {
            this.item_id = item_id;
            this.item_name = item_name;
            this.item_price = item_price; 
        }
    }
}