using Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Model
{
    public class UserQueryModel : PaginationQueryModel
    {
        public string KeyWord { get; set; } = string.Empty;
    }

    public class UserViewModel
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Account { get; set; }
        public string DepCode { get; set; }
    }
}
