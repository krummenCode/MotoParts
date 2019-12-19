using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Models
{
    public class PartModel
    {
        public int PartID { get; set; }
        public int DirtBikeIDFK { get; set; }
        public string PartName { get; set; }
        public string Picture { get; set; }
        public decimal Price { get; set; }
        public string PartDescription { get; set; }
        public int BrandIDFK { get; set; }
        public string BrandName { get; set; }
        public int CategoryIDFK { get; set; }
        public int PartQuantity { get; set; }
    }
}