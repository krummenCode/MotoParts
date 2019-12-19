using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsCommon
{
    public class Part
    {
        public Part() { }
        public Part(int iPartID, int iDirtBikeIDFK, string iPartName, string iPicture, decimal iPrice, string iPartDescription, int iBrandIDFK, string iBrandName,  int iCategoryIDFK, int iPartQuantity)
        {
            this.PartID = iPartID;
            this.DirtBikeIDFK = iDirtBikeIDFK;
            this.PartName = iPartName;
            this.Picture = iPicture;
            this.Price = iPrice;
            this.PartDescription = iPartDescription;
            this.BrandIDFK = iBrandIDFK;
            this.BrandName = iBrandName;
            this.CategoryIDFK = iCategoryIDFK;
            this.PartQuantity = iPartQuantity;
        }


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
