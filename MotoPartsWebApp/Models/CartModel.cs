using MotoPartsCommon;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Models
{
    public class CartModel
    {
        public decimal CartSubtotal { get; set; }
        public decimal TaxTotal { get; set; }
        public decimal CartTotal { get; set; }
        public List<Part> PartList { get; set; }
    }
}