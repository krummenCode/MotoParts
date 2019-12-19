using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MotoPartsBLL;
using MotoPartsCommon;

namespace MotoPartsUnitTest
{
    [TestClass]
    public class UnitTest_ViewCartBLL
    {
        [TestMethod]
        public void Test_Calculate_Subtotal()
        {
            // Arrange
            List<Part> listPart = new List<Part>();

            // Create mock parts for test
            Part part1 = new Part { Price = Convert.ToDecimal(100.50), PartQuantity = 2 };
            listPart.Add(part1);

            Part part2 = new Part { Price = Convert.ToDecimal(10), PartQuantity = 1 };
            listPart.Add(part2);

            Part part3 = new Part { Price = Convert.ToDecimal(25.25), PartQuantity = 4 };
            listPart.Add(part3);

            ViewCartBLL viewCartBLL = new ViewCartBLL();


            // Act
            decimal actual = viewCartBLL.GetCartSubtotal(listPart);
            decimal expect = 312;


            // Assert
            Assert.AreEqual(expect, actual);

        }



        [TestMethod]
        public void Test_Calculate_TaxTotal()
        {
            // Arrange
            List<Part> listPart = new List<Part>();

            Part part1 = new Part { Price = Convert.ToDecimal(100.50), PartQuantity = 2 };
            listPart.Add(part1);

            Part part2 = new Part { Price = Convert.ToDecimal(10), PartQuantity = 1 };
            listPart.Add(part2);

            Part part3 = new Part { Price = Convert.ToDecimal(25.25), PartQuantity = 4 };
            listPart.Add(part3);

            ViewCartBLL viewCartBLL = new ViewCartBLL();


            // Act
            decimal subTotal = viewCartBLL.GetCartSubtotal(listPart);
            decimal actual = viewCartBLL.GetCartTaxTotal(subTotal);

            decimal expect = Convert.ToDecimal(23.4);

            // Assert
            Assert.AreEqual(expect, actual);

        }



        [TestMethod]
        public void Test_Calculate_CartTotal()
        {
            // Arrange
            List<Part> listPart = new List<Part>();

            Part part1 = new Part { Price = Convert.ToDecimal(100.50), PartQuantity = 2 };
            listPart.Add(part1);

            Part part2 = new Part { Price = Convert.ToDecimal(10), PartQuantity = 1 };
            listPart.Add(part2);

            Part part3 = new Part { Price = Convert.ToDecimal(25.25), PartQuantity = 4 };
            listPart.Add(part3);

            ViewCartBLL viewCartBLL = new ViewCartBLL();


            // Act
            decimal subTotal = viewCartBLL.GetCartSubtotal(listPart);
            decimal taxTotal = viewCartBLL.GetCartTaxTotal(subTotal);
            decimal actual = viewCartBLL.GetCartTotal(subTotal, taxTotal);

            decimal expect = Convert.ToDecimal(335.4);

            // Assert
            Assert.AreEqual(expect, actual);

        }
    }
}
