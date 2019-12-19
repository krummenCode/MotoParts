using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class DeletePartBLL
    {
        public bool DeletePart(int PartId)
        {
            DeletePartDAL deletePartDAL = new DeletePartDAL();
            bool b = deletePartDAL.DeletePart(PartId);
            return b;
        }
    }
}
