using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MotoPartsCommon;
using MotoPartsDAL;

namespace MotoPartsBLL
{
    public class ViewAllUsersBLL
    {
        public List<User> ViewAllUsers(User user)
        {
            List<User> listUsers = new List<User>();
            ViewAllUsersDAL viewAllUsersDAL = new ViewAllUsersDAL();
            listUsers = viewAllUsersDAL.ViewAllUsers(user);
            return listUsers;
        }
    }
}
