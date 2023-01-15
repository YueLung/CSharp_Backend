using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;


namespace Core.Models
{
    public static class Roles
    {
        public const string Admin = nameof(Admin);

        public const string Test = nameof(Test);
    }

    public class SigninRequestModel
    {
        [Required]
        public string Account { get; set; }
        public string Password { get; set; }
    }
}
