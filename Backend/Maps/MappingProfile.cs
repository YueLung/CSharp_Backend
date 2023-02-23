using System;
using System.Linq;
using System.Collections.Generic;
using AutoMapper;
using Core.Entities;
using Application.Model;

namespace Backend.Maps
{
    public class MappingProfile: Profile
    {
        public MappingProfile()
        {
            CreateMap<Base_Auth_User, UserViewModel>();
        }
       
    }
}
