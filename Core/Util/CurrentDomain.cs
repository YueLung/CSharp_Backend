using System;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Core.Util
{
    public static class CurrentDomain
    {
        public static Assembly[] Assemblies()
        {
            return Directory.GetFiles(AppDomain.CurrentDomain.BaseDirectory, "*.dll")
                    .Select(x => Assembly.Load(AssemblyName.GetAssemblyName(x)))
                    ?.ToArray();
        }
    }
}
