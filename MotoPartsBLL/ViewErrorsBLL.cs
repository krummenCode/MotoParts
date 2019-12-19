using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class ViewErrorsBLL
    {
        public List<Error> ViewAllErrors(Error er)
        {
            List<Error> listErrors = new List<Error>();
            ExceptionHandling iErrorDAL = new ExceptionHandling();
            listErrors = iErrorDAL.ViewAllErrors(er);
            return listErrors;
        }
    }
}
