using System;
using System.Collections.Generic;
using System.Text;

namespace Core.Models
{
    public interface ISucessResponse
    {
        object Model { get; set; }
    }

    public class SucessResponse
    {
        public object Model { get; set; }
    }

}
