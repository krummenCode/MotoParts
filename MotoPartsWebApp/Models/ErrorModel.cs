using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Models
{
    public class ErrorModel
    {
        public int ErrorID { get; set; }
        public DateTime ErrorDate { get; set; }
        public string StackTrace { get; set; }
        public string Message { get; set; }
    }
}