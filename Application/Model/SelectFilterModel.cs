using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Model
{
    public class SelectFilterRequestModel
    {
        [Required]
        public string KeyWord { get; set; }
        [Required]
        public int TakeCount { get; set; }
    }

    public class SelectFilterViewModel
    {
        public Guid Id { get; set; }
        public string Text { get; set; }
        public string OptionDisplay { get; set; }
        public bool Active { get; set; }

        public object Expando{ get; set; }
    }
}
