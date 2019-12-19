using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class DeletePartFromCartBLL
    {
        public void DeletePartFromCart(int iUserID, int iPartID)
        {
            DeletePartFromCartDAL deletePartFromCartDAL = new DeletePartFromCartDAL();
            deletePartFromCartDAL.DeletePartFromCart(iUserID, iPartID);
        }
    }
}
