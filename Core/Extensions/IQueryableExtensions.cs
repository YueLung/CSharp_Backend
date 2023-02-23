using Core.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Extensions
{
    public static class IQueryableExtensions
    {
        //public static IQueryable<TSource> PaginationOrderByQuery<TSource>(this IQueryable<TSource> query, [NotNull] PaginationQueryModel pagination)
        //{
        //    if (pagination.OrderBy == PaginationOrderBy.)
        //}

        public static IQueryable<TSource> PaginationTakeQuery<TSource>(this IQueryable<TSource> query, [NotNull] PaginationQueryModel pagination)
        {
            var skip = (pagination.Page - 1) * pagination.Size;
            var take = pagination.Size;

            if (skip >0 )query = query.Skip(skip);

            return query.Take(take);
        }
    }
}
