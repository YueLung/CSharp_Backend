using System;
using System.Collections.Generic;
using System.Reflection;
using Autofac;
using Backend;
using Backend.Extensions;
using Core.Extensions;
using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Backend
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();

            services.AddCorsSettings(Configuration);

            services.AddJwtAuth(Configuration);

            services.AddConfigSettings(Configuration);

            services.AddDbContext(Configuration);

            // 需增加這一行Controller才可以屬性注入
            // https://reurl.cc/Epk6qg
            services.AddControllers().AddControllersAsServices();

            // https://stackoverflow.com/questions/38709538/no-service-for-type-microsoft-aspnetcore-mvc-viewfeatures-itempdatadictionaryfa
            services.AddControllersWithViews();

            services.AddSwaggerOpenApi();
        }

        public void ConfigureContainer(ContainerBuilder builder)
        {
            builder.RegisterModule(new AutofacConfig(Configuration));
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.Use(async (context, next) =>
            {
                //await context.Response.WriteAsync("First Middleware in. \r\n");
                await next();
                //await context.Response.WriteAsync("First Middleware out. \r\n");

            });

            app.UseCorsSettings();

            app.UseHttpsRedirection();

            app.UseSwaggerSettings();

            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
