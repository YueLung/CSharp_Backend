using Core.Utils;
using Microsoft.Extensions.DependencyInjection;

namespace Backend.Extensions
{
    public static class AutoMapperExtensions
    {
        public static void AddMapper(this IServiceCollection services)
        {
            var assemblies = CurrentDomain.Assemblies();
            services.AddAutoMapper(assemblies);
        }
    }
}
