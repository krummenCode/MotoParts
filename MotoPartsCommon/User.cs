using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MotoPartsCommon
{
    public class User
    {
        public User() { }
        public User(int iUserID, string iFirstName, string iLastName, string iUserName, string iUserPassword, 
            string iSalt, string iEmail, int iRoleIDFK, int iSavedDirtbikeIDFK)
        {
            this.UserID = iUserID;
            this.FirstName = iFirstName;
            this.LastName = iLastName;
            this.UserName = iUserName;
            this.UserPassword = iUserPassword;
            this.Salt = iSalt;
            this.Email = iEmail;
            this.RoleIDFK = iRoleIDFK;
            this.SavedDirtbikeIDFK = iSavedDirtbikeIDFK;

        }

        public int UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string Salt { get; set; }
        public string Email { get; set; }
        public int RoleIDFK { get; set; }
        public int SavedDirtbikeIDFK { get; set; }
    }
}
