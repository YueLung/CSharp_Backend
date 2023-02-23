using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Models;

namespace Core.Extensions
{
    public static class ResponsePageExtensions
    {
        public static ResponseHasPageModel AsResponsePageResult<TModel>(this IEnumerable<TModel> model, PaginationQueryModel pagination, int totalRecord)
        {
            int totalPage = 0;
            int pageSize = pagination.Size;

            if (pageSize > 0)
            {
                totalPage = totalRecord / pageSize + (totalRecord % pageSize != 0 ? 1 : 0);
            }

            return new ResponseHasPageModel()
            {
                Model = model,
                DataPage = new PaginationModel()
                {
                    PageSize = pagination.Size,
                    PageNumber = pagination.Page,
                    TotalRecord = totalRecord,
                    TotalPages = totalPage
                }
            };
        }
    }
}
