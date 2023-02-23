using System;
using System.Net;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Configuration;
using MediatR;
using Core.Models;
using Application.Command.Auth;
using Application.Command.Test;
using Application.Model;

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

        /// <summary>
        /// test data
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [HttpGet("data")]
        [ProducesResponseType(typeof(string), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public string GetTestString()
        {
            return "test";
        }

        [AllowAnonymous]
        [HttpPost("user/list")]
        [ProducesResponseType(typeof(ResponseHasPageModel), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        public async Task<IActionResult> GetUserList(UserQueryModel model)
        {
            var result = await _mediator.Send(new GetUserListCommand(model));
            return Ok(result);
        }

        [AllowAnonymous]
        [HttpPost("signin-test")]
        public async Task<IActionResult> SigninTest(SigninRequestModel model)
        {
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
