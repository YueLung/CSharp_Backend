using System;
using System.Collections.Generic;
using System.Text;
using Core.Models;

namespace Core.Interface
{
    public interface IAuthDomain
    {
        string Signin(SigninRequestModel model);

        string MockSignin(SigninRequestModel model);
    }
}
