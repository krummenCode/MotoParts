using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsCommon
{
    public class Dirtbike
    {
        public Dirtbike() { }
        public Dirtbike(int iDirtBikeID, string iMake, int iMakeYear, string iModel)
        {
            this.DirtBikeID = iDirtBikeID;
            this.Make = iMake;
            this.MakeYear = iMakeYear;
            this.Model = iModel;
        }


        public int DirtBikeID { get; set; }
        public string Make { get; set; }
        public int MakeYear { get; set; }
        public string Model { get; set; }
        // public List<Part> Parts {get; set;}
    }
}
