using System;
using System.Linq;
using System.Collections.Generic;

namespace Core.Interface
{
    public interface IRepository<TEntity>
    {
        IList<TEntity> All();

        IQueryable<TEntity> AsQueryable();


        void Add(TEntity entity);

        void Add(List<TEntity> entities);

        void Update(TEntity entity);

        void Delete(TEntity entity);
    }
}
