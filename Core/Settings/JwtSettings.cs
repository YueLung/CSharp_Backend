using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Settings
{
    public class JwtSettings
    {
        public string Issuer { get; set; }

        public string SignKey { get; set; }
    }
}
