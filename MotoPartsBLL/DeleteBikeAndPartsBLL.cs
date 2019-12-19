using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class DeleteBikeAndPartsBLL
    {
        public bool CascadeDeletePartAndDirtbike(int iBikeID)
        {
            DeleteBikeAndPartsDAL iDeleteBikeAndPartsDAL = new DeleteBikeAndPartsDAL();
            bool b = iDeleteBikeAndPartsDAL.CascadeDeletePartAndDirtbike(iBikeID);
            return b;
        }
    }
}
