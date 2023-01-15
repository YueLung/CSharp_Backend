using System.Text;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Core.Extensions;

namespace Backend.Extensions
{
    public static class JwtAuthExtension
    {
        public static void AddJwtAuth(this IServiceCollection services, IConfiguration configuration)
        {

            var jwtSettings = configuration.GetJwtSettings();


            services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(x =>
            {
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SignKey)),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };
            });


            //services.AddAuthentication(x =>
            //{
            //    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            //    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            //})
            //.AddJwtBearer(options =>
            //{
            //    // 當驗證失敗時，回應標頭會包含 WWW-Authenticate 標頭，這裡會顯示失敗的詳細錯誤原因
            //    options.IncludeErrorDetails = true; // 預設值為 true，有時會特別關閉

            //    options.TokenValidationParameters = new TokenValidationParameters
            //    {
            //        // 透過這項宣告，就可以從 "sub" 取值並設定給 User.Identity.Name
            //        NameClaimType = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier",
            //        // 透過這項宣告，就可以從 "roles" 取值，並可讓 [Authorize] 判斷角色
            //        RoleClaimType = "http://schemas.microsoft.com/ws/2008/06/identity/claims/role",

            //        // 一般我們都會驗證 Issuer
            //        ValidateIssuer = true,
            //        ValidIssuer = jwtSettings.Issuer,

            //        // 通常不太需要驗證 Audience
            //        ValidateAudience = false,
            //        //ValidAudience = "JwtAuthDemo", // 不驗證就不需要填寫

            //        // 一般我們都會驗證 Token 的有效期間
            //        ValidateLifetime = true,

            //        // 如果 Token 中包含 key 才需要驗證，一般都只有簽章而已
            //        ValidateIssuerSigningKey = false,

            //        // "1234567890123456" 應該從 IConfiguration 取得
            //        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SignKey))
            //    };
            //});

            services.AddAuthorization();
        }
    }
}
