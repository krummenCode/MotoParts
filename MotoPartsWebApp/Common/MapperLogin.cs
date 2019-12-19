using MotoPartsCommon;
using MotoPartsWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Common
{
    public class MapperLogin
    {
        public User MapUser(LoginModel Um)
        {
            // using constructor with parameters
            User user = new User(Um.UserID, Um.FirstName, Um.LastName, Um.UserName, Um.UserPassword,
                Um.Salt, Um.Email, Um.RoleIDFK, Um.SavedDirtbikeIDFK);

            return user;
        }
    }
}