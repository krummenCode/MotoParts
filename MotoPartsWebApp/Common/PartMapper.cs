using MotoPartsCommon;
using MotoPartsWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Common
{
    public class PartMapper
    {
        public Part MapDirtbike(PartModel iPartModel)
        {
            // Create constructor
            Part iPart = new Part(iPartModel.PartID, iPartModel.DirtBikeIDFK, iPartModel.PartName, iPartModel.Picture, iPartModel.Price,
                iPartModel.PartDescription, iPartModel.BrandIDFK, iPartModel.BrandName, iPartModel.CategoryIDFK, iPartModel.PartQuantity);

            return iPart;
        }
    }
}