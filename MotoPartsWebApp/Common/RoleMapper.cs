using MotoPartsCommon;
using MotoPartsWebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MotoPartsWebApp.Common
{
    public class RoleMapper
    {
        public Role MapRole(RoleModel r)
        {
            // using constructor with parameters
            Role role = new Role(r.RoleID, r.RoleName);

            return role;
        }
    }
}