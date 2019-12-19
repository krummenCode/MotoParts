using MotoPartsCommon;
using MotoPartsWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Common
{
    public class MapperDirtbike
    {
        public Dirtbike MapDirtbike(DirtbikeModel iDirtbikeModel)
        {
            // Create constructor
            Dirtbike iDirtbike = new Dirtbike(iDirtbikeModel.DirtBikeID, iDirtbikeModel.Make, iDirtbikeModel.MakeYear, iDirtbikeModel.Model);

            return iDirtbike;
        }
    }
}