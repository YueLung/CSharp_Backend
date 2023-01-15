using Core.Settings;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Core.Extensions
{
    // https://tinyurl.com/4bvhs5dy
    public static class ConfigureExtensions
    {
        public static string JwtSettings = nameof(JwtSettings);

        public static string GetDefaultConnectionStrings(this IConfiguration configuration)
        {
            return configuration.GetConnectionString("DefaultConnection");
        }

        public static JwtSettings GetJwtSettings(this IConfiguration configuration)
        {

            return configuration.GetConfig<JwtSettings>();
        }

        public static CorsSettings GetCorsSettings(this IConfiguration configuration)
        {

            return configuration.GetConfig<CorsSettings>();
        }

        public static T GetConfig<T>(this IConfiguration configuration) where T : class
        {
            // 這邊要用 typeof(T).Name nameof 好像只會回傳 'T'
            return configuration.GetSection(typeof(T).Name).Get<T>();
        }

        public static void AddConfigSettings(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddConfig<JwtSettings>(configuration);
        }

        public static void AddConfig<T>(this IServiceCollection services, IConfiguration configuration) where T : class
        {
            services.Configure<T>(option => configuration.GetSection(nameof(T)).Bind(option));
        }
    }
}
