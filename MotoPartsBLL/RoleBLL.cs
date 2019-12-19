using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class RoleBLL
    {
        public List<Role> CollectRoles(Role iRole)
        {
            List<Role> listRoles = new List<Role>();
            RoleDAL iRoleDAL = new RoleDAL();
            listRoles = iRoleDAL.SelectRolesFromTable(iRole);
            return listRoles;

        }
    }
}
