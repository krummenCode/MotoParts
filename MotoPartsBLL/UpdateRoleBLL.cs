using MotoPartsCommon;
using MotoPartsDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsBLL
{
    public class UpdateRoleBLL
    {
        public bool UpdateRole(int userID, int userRole)
        {
            UpdateRoleDAL updateRoleDAL = new UpdateRoleDAL();
            bool b = updateRoleDAL.updateRole(userID, userRole);
            return b;
        }
    }
}
