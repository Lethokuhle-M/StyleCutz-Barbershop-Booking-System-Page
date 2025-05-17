using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StyleCutzBarberShopWebApp.Private.Manager
{
    public class CartProduct
    {
        public int ItemId { get; set; }
        public string ItemName { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        
        public CartProduct(int ItemId, string ItemName, decimal Price, int Quantity)
        {
            this.ItemId = ItemId;
            this.ItemName = ItemName;
            this.Price = Price;
            this.Quantity = Quantity;
        }
    }
}