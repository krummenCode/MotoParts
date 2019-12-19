using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

/// <summary>
/// Name:           David Krummen 
/// Company:        Onshore Outsourcing Bootcamp
/// Description:    Used to store info from the register process
/// </summary>

namespace MotoPartsWebApp.Models
{
    public class UserModel
    {
        public int UserID { get; set; }

        [Required(ErrorMessage = "*Required: First name")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "*Required: Last name")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "*Required: Username")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "*Required: Password")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,20}$", ErrorMessage = "Must contain a lowercase letter, uppercase letter, special character, number and 8-20 characters long.")]
        public string UserPassword { get; set; }

        public string Salt { get; set; }

        [Required(ErrorMessage = "*Required: Email")]
        public string Email { get; set; }

        public int RoleIDFK { get; set; }

        public int SavedDirtbikeIDFK { get; set; }

    }
}