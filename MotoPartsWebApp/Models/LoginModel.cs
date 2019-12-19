using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

/// <summary>
/// Name:           David Krummen 
/// Company:        Onshore Outsourcing Bootcamp
/// Description:    Used to store info from the login process
/// </summary>

namespace MotoPartsWebApp.Models
{
    public class LoginModel
    {
        public int UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        [Required(ErrorMessage = "*Required: Username")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "*Required: Password")]
        public string UserPassword { get; set; }

        public string Salt { get; set; }

        public string Email { get; set; }

        public int RoleIDFK { get; set; }

        public int SavedDirtbikeIDFK { get; set; }
    }
}