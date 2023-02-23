using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;

namespace Backend.Extensions
{
    // https://igouist.github.io/post/2021/05/newbie-4-swagger/
    // https://igouist.github.io/post/2021/10/swagger-enable-authorize/
    public static class SwaggerExtensions
    {
        public static void AddSwaggerOpenApi(this IServiceCollection services)
        {
            // Register the Swagger services
            services.AddSwaggerDocument(config =>
            {
                config.PostProcess = document =>
                {
                    document.Info.Version = "v1";
                    document.Info.Title = "ToDo API";
                    document.Info.Description = "A simple ASP.NET Core web API";
                    document.Info.TermsOfService = "None";
                    //document.Info.Contact = new NSwag.OpenApiContact
                    //{
                    //    Name = "Shayne Boyer",
                    //    Email = string.Empty,
                    //    Url = "https://twitter.com/spboyer"
                    //};
                    //document.Info.License = new NSwag.OpenApiLicense
                    //{
                    //    Name = "Use under LICX",
                    //    Url = "https://example.com/license"
                    //};
                };
            });


            //services.AddSwaggerGen();

            //services.AddSwaggerGen(options =>
            //{
            //    // API 服務簡介
            //    options.SwaggerDoc("v1", new OpenApiInfo
            //    {
            //        Version = "v1",
            //        Title = "JWT Demo",
            //        Description = "JWT API",
            //    });

            //    options.AddSecurityDefinition("Bearer",
            //        new OpenApiSecurityScheme
            //        {
            //            Name = "Authorization",
            //            Type = SecuritySchemeType.ApiKey,
            //            Scheme = "Bearer",
            //            BearerFormat = "JWT",
            //            In = ParameterLocation.Header,
            //            Description = "JWT Authorization"
            //        }
            //    );

            //    options.AddSecurityRequirement(
            //        new OpenApiSecurityRequirement
            //        {
            //            {
            //                new OpenApiSecurityScheme
            //                {
            //                    Reference = new OpenApiReference
            //                    {
            //                        Type = ReferenceType.SecurityScheme,
            //                        Id = "Bearer"
            //                    }
            //                },
            //                new string[] {}
            //            }
            //        });

            // 讀取 XML 檔案產生 API 說明
            //var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
            //var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
            //options.IncludeXmlComments(xmlPath);
            //});
        }

        public static void UseSwagger(this IApplicationBuilder app)
        {
            // Register the Swagger generator and the Swagger UI middlewares
            app.UseOpenApi();
            app.UseSwaggerUi3();


            //SwaggerBuilderExtensions.UseSwagger(app);
            //app.UseSwaggerUI(c =>
            //{
            //    c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
            //});
        }
    }
}
