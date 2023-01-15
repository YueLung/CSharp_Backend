using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Data.sql.Entities;
using Core.Interface;

namespace Data.sql.DataAccess
{
    public class UnitOfWork : IUnitOfWork, IDependencyInjection
    {
        readonly ContextBase _contextBase;

        public UnitOfWork(ContextBase contextBase)
        {
            _contextBase = contextBase;
        }

        public int saveChanges()
        {
            try
            {
                return _contextBase.SaveChanges();
            }
            catch (Exception ex)
            {
                return -1;
            }
            finally
            {
                foreach (var state in _contextBase.ChangeTracker.Entries())
                {
                    state.State = EntityState.Detached;
                }
            }
        }
    }
}
