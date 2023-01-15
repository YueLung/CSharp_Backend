using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Interface
{
    public interface IUnitOfWork
    {
        int saveChanges();
    }
}
