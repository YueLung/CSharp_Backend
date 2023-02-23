using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using AutoMapper;
using Core.Interface;
using Core.Models;
using Core.Entities;
using Core.Extensions;
using Application.Model;


namespace Application.Command.Test
{
    public class GetUserListCommand : IRequest<ResponseHasPageModel>
    {
        public UserQueryModel QueryModel { get; }
        public GetUserListCommand(UserQueryModel queryModel) => QueryModel = queryModel;
    }

    public class GetUserListCommandHandler : IRequestHandler<GetUserListCommand, ResponseHasPageModel>
    {
        private readonly IRepository<Base_Auth_User> _repo;
        private readonly IMapper _mapper;

        public GetUserListCommandHandler(
            IRepository<Base_Auth_User> repo,
            IMapper mapper
        )
        {
            _repo = repo;
            _mapper = mapper;
        }

        public Task<ResponseHasPageModel> Handle(GetUserListCommand request, CancellationToken cancellationToken)
        {
            var queryModel = request.QueryModel;

            var query = _repo.AsQueryable();

            if (!string.IsNullOrWhiteSpace(queryModel.KeyWord))
            {
                query = query.Where(x => x.Name.Contains(queryModel.KeyWord));
            }

            var totalRecord = query.Count();

            var entities = query
                .PaginationTakeQuery(queryModel)
                .ToList();

            var result = entities.AsResponsePageResult(queryModel, totalRecord);

            var model = _mapper.Map<IEnumerable<UserViewModel>>(entities);
            result.Model = model;

            return Task.FromResult(result);
        }
    }
}
