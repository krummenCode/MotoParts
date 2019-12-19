using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class DeleteUserBLL
    {
        public bool DeleteUser(int UserId)
        {
            DeleteUserDAL deleteUserDAL = new DeleteUserDAL();
            bool b = deleteUserDAL.DeleteUser(UserId);
            return b;
        }
    }
}
