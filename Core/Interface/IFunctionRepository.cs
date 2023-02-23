using System;

namespace Core.Interface
{
    public interface IFunctionRepository
    {
        string GetPasswordHash(string id, string password);
    }
}
