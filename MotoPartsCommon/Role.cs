using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsCommon
{
    public class Role
    {
        public Role() { }

        public Role(int iRoleID, string iRoleName)
        {
            this.RoleID = iRoleID;
            this.RoleName = iRoleName;
        }


        public int RoleID { get; set; }
        public string RoleName { get; set; }
    }
}
