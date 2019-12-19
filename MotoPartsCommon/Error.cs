using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsCommon
{
    public class Error
    {
        public Error() { }
        public Error(int iErrorID, DateTime iErrorDate, string iStackTrace, string iMessage)
        {
            this.ErrorID = iErrorID;
            this.ErrorDate = iErrorDate;
            this.StackTrace = iStackTrace;
            this.Message = iMessage;
        }


        public int ErrorID { get; set; }
        public DateTime ErrorDate { get; set; }
        public string StackTrace { get; set; }
        public string Message { get; set; }
    }
}
