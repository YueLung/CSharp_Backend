using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Core.Interface;
using Core.Models;


namespace Application.Command.Auth
{
    public class MockSignInCommand : IRequest<string>
    {
        public SigninRequestModel SigninModel { get; }
        public MockSignInCommand(SigninRequestModel signinModel) => SigninModel = signinModel;
    }

    public class MockSignInCommandHandler : IRequestHandler<MockSignInCommand, string>
    {
        private IAuthDomain _authDomain;
        public MockSignInCommandHandler(IAuthDomain authDomain)
        {
            _authDomain = authDomain;
        }

        public Task<string> Handle(MockSignInCommand request, CancellationToken cancellationToken)
        {
            string result = _authDomain.MockSignin(request.SigninModel);
            return Task.FromResult(result);
        }
    }
}
