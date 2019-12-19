using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class AddPartBLL
    {
        public bool AddPart(Part iPart)
        {
            AddPartDAL addPartDAL = new AddPartDAL();
            bool b = addPartDAL.AddPart(iPart);
            return b;
        }
    }
}
