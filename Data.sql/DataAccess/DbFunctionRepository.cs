using System;
using System.Linq;
using System.Data;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Core.Interface;
using Data.sql.Entities;
using Dapper;


namespace Data.sql.DataAccess
{
    public class DbFunctionRepository : IFunctionRepository, IDependencyInjection
    {
        private readonly ContextBase _contextBase;

        public DbFunctionRepository(ContextBase contextBase)
        {
            _contextBase = contextBase;
        }

        public string GetPasswordHash(string id, string password)
        {
            var dbConnection = _contextBase.Database.GetDbConnection();

            var hash = dbConnection.Query<string>("Select db.Fn_Password_Hash(@id, @password)",
                new { id = id, password = password },
                commandType: CommandType.Text
                ).First();

            return hash;
        }
    }
}
