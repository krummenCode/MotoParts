using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class RegistrationBLL
    {
        public User Register(User user)
        {
            User u = new User();
            RegistrationDAL registrationDAL = new RegistrationDAL();
            u = registrationDAL.CreateNewUser(user);
            return u;
        }
    }
}
