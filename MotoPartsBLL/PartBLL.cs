using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class PartBLL
    {
        public List<Part> SelectAllParts(Part iPart)
        {
            List<Part> listParts = new List<Part>();
            PartDAL iPartDAL = new PartDAL();
            listParts = iPartDAL.SelectPart(iPart);
            return listParts;
        }
    }
}
