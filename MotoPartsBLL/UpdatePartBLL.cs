using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class UpdatePartBLL
    {
        public void UpdatePart(Part iPart)
        {
            UpdatePartDAL updatePartDAL = new UpdatePartDAL();
            updatePartDAL.UpdatePart(iPart);
        }
    }
}
