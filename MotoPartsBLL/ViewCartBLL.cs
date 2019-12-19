using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class ViewCartBLL
    {
        // Use User ID as parameter to get all parts that user added to their cart in database
        public List<Part> GetPartsInCart(int iUserID)
        {
            ViewCartDAL viewCartDAL = new ViewCartDAL();
            List<Part> listPartsInCart = viewCartDAL.GetPartsInCart(iUserID);
            return listPartsInCart;
        }


        // Loop through each part in User's returned list and add the prices together
        public decimal GetCartSubtotal(List<Part> listPartsInCart)
        {
            decimal CartSubtotal = 0;

            foreach (Part p in listPartsInCart)
            {
                // Part Price times Part Quantity
                CartSubtotal += p.Price * p.PartQuantity;

            }

            return (CartSubtotal);
        }

        
        // Take sub total and multiply to missouri's average tax rate to get tax total
        public decimal GetCartTaxTotal(decimal CartSubtotal)
        {

            decimal MissouriAvgSalesTaxRate = Convert.ToDecimal(0.075);
            decimal TaxTotal = CartSubtotal * MissouriAvgSalesTaxRate;
            decimal TaxTotalRnd = Math.Round(TaxTotal, 2);

            return (TaxTotalRnd);
        }


        // Calculate Grand total with subtotal and taxtotal
        public decimal GetCartTotal(decimal TaxTotal, decimal CartSubtotal)
        {

            decimal CartTotal = TaxTotal + CartSubtotal;

            return (CartTotal);
        }
    }
}
