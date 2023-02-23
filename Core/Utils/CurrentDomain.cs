using System;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Core.Utils
{
    public static class CurrentDomain
    {
        public static Assembly[] Assemblies()
            => Directory.GetFiles(AppDomain.CurrentDomain.BaseDirectory, "*.dll")
                .Where(x => !AssemblyName.GetAssemblyName(x).Name.EndsWith("Views"))
                .Select(x => Assembly.Load(AssemblyName.GetAssemblyName(x)))
                ?.ToArray();

    }
}
