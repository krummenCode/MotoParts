using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class AddPartToCartBLL
    {
        public void AddPartToCart(int UserIDFK, int PartIDFK, decimal PartPrice, string PartName, string PartBrand, string Picture)
        {
            AddPartToCartDAL iAddPartToCartDAL = new AddPartToCartDAL();
            iAddPartToCartDAL.AddPartToCart(UserIDFK, PartIDFK, PartPrice, PartName, PartBrand, Picture);
        }
    }
}
