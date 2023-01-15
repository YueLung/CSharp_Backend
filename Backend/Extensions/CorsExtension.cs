using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Core.Extensions;

namespace Backend.Extensions
{
    public static class CorsExtension
    {
        public static void AddCorsSettings(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddCors(options =>
            {
                var corsSettings = configuration.GetCorsSettings();

                // Policy 名稱 CorsPolicy 是自訂的，可以自己改
                options.AddPolicy("CorsPolicy", policy =>
                {
                    // 設定允許跨域的來源，有多個的話可以用 `,` 隔開
                    policy.WithOrigins("http://localhost:4200")
                            .AllowAnyHeader()
                            .WithMethods(corsSettings.Methods)
                            .AllowCredentials();
               
                });
            });
        }

        public static void UseCorsSettings(this IApplicationBuilder app)
        {
            app.UseCors("CorsPolicy");
        }
    }
}
