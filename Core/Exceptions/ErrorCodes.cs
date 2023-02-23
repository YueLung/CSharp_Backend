using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Exceptions
{
    public sealed class ErrorCodes
    {
        public sealed class Signin 
        {
            /// <summary> AD Server 異常 </summary>
            public const string ADException = "AUTH-SIGNIN-E02";
            /// <summary> 帳號密碼錯誤 </summary>
            public const string Unauthenticated = "AUTH-SIGNIN-E02";
            /// <summary> 帳號未啟用 </summary>
            public const string Disable = "AUTH-SIGNIN-E03";
        }
    }
}
