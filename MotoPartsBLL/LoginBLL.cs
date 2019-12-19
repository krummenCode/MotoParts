using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class LoginBLL
    {
        public List<User> Login(User user)
        {
            List<User> listUser = new List<User>();
            LoginDAL loginDAL = new LoginDAL();

            listUser = loginDAL.LoginUser(user);

            return listUser;
        }
    }
}
