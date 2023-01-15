using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Data.sql.Entities;
using Core.Extensions;

namespace Backend.Extensions
{
    public static class MsSqlExtensions
    {
        public static void AddDbContext(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<ContextBase>(options =>
            {
                string connectionString = configuration.GetDefaultConnectionStrings();
                options.UseSqlServer(connectionString);
            });
        }
    }
}
