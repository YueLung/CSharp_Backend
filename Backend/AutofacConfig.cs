
using System;
using System.Linq;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Autofac;
using MediatR;
using MediatR.Extensions.Autofac.DependencyInjection;
using Data.sql.DataAccess;
using Core.Interface;
using Core.Util;

namespace Backend
{
    public class AutofacConfig : Autofac.Module
    {
        private IConfiguration _configuration;
        public AutofacConfig(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterGeneric(typeof(DbRepository<>)).As(typeof(IRepository<>));

            var assemblies = CurrentDomain.Assemblies();

            RegisterDependency(builder, assemblies);

            RegisterMediatR(builder, assemblies);
        }

        private void RegisterMediatR(ContainerBuilder builder, Assembly[] assemblies)
        {
            builder.RegisterAssemblyTypes(assemblies)
                   .Where(t => !t.GetType().IsAbstract && t.IsClosedTypeOf(typeof(IRequest<>)))
                   .AsImplementedInterfaces();

            builder.RegisterMediatR(assemblies);
        }

        private void RegisterDependency(ContainerBuilder builder, Assembly[] assemblies)
        {
            builder
                .RegisterAssemblyTypes(assemblies)
                .Where(t => t.GetInterfaces().Any(i => i.IsAssignableFrom(typeof(IDependencyInjection))))
                .AsImplementedInterfaces()
                .InstancePerLifetimeScope(); // Add similar for the other two lifetimes

            builder.RegisterAssemblyTypes(assemblies)
                .Where(type => !type.IsAbstract && type.Name.EndsWith("Controller"))
                .PropertiesAutowired();
        }
    }
}
