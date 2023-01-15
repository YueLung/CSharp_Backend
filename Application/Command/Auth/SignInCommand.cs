using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Core.Interface;
using Core.Models;


namespace Application.Command.Auth
{
    public class SignInCommand : IRequest<string>
    {
        public SigninRequestModel SigninModel { get; }
        public SignInCommand(SigninRequestModel signinModel) => SigninModel = signinModel;
    }

    public class SignInCommandHandler : IRequestHandler<SignInCommand, string>
    {
        private IAuthDomain _authDomain;
        public SignInCommandHandler(IAuthDomain authDomain)
        {
            _authDomain = authDomain;
        }

        public Task<string> Handle(SignInCommand request, CancellationToken cancellationToken)
        {
            string result = _authDomain.Signin(request.SigninModel);
            return Task.FromResult(result);
        }
    }
}
