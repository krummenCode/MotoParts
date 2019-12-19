using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class DirtbikeBLL
    {
        public List<Dirtbike> Select(Dirtbike iDirtbike)
        {
            List<Dirtbike> listDirtbike = new List<Dirtbike>();
            DirtbikeDAL iDirtbikeDAL = new DirtbikeDAL();
            listDirtbike = iDirtbikeDAL.SelectDirtbike(iDirtbike);
            return listDirtbike;
        }

    }
}
