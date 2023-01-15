using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Data.sql.Entities;
using Core.Interface;

namespace Data.sql.DataAccess
{
    public class DbRepository<TEntity> : IRepository<TEntity> 
        where TEntity :class
    {
        #region member

        private readonly ContextBase _contextBase;

        #endregion

        #region Properties

        private DbSet<TEntity> Entity => _contextBase.Set<TEntity>();

        #endregion

        public DbRepository(ContextBase contextBase)
        {
            _contextBase = contextBase;
        }
   
        public IList<TEntity> All() => Entity.ToList();

        public IQueryable<TEntity> AsQueryable() => Entity;

        #region CUD

        public void Add(TEntity entity)
            => _contextBase.Add(entity);

        public void Add(List<TEntity> entities)
            => entities.ForEach(entity => _contextBase.Add(entity));

        public void Update(TEntity entity)
            => _contextBase.Entry(entity).State = EntityState.Modified;

        public void Delete(TEntity entity)
            => _contextBase.Entry(entity).State = EntityState.Deleted;

        #endregion
    }
}
