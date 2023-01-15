using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Configuration;
using Core.Models;
using MediatR;
using Application.Command.Auth;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ApiControllerBase
    {
        private readonly IConfiguration _configuration;

        public TestController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "test1", "test2" };
        }

        [AllowAnonymous]
        [HttpGet("data")]
        public string GetTestString()
        {
            return "test";
        }

        [AllowAnonymous]
        [HttpPost("signin-test")]
        public async Task<IActionResult> SigninTest()
        {
            var model = new SigninRequestModel()
            {
                Account = "Test",
                Password = "0000"
            };
            var result = await _mediator.Send(new MockSignInCommand(model));
            return Ok(result);
        }

        [Authorize(Roles = "Test")]
        [HttpGet("auth-data")]
        public string GetAuthTestString()
        {
            return "auth-test";
        }

    }
}
