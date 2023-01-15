using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Core.Models;
using Application.Command.Auth;


namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ApiControllerBase
    {
        [AllowAnonymous]
        [HttpPost("signin")]
        public async Task<IActionResult> Signin()
        {
            var model = new SigninRequestModel()
            {
                Account = "123",
                Password = "456"
            };
            var result = await _mediator.Send(new SignInCommand(model));
            return Ok(result);
        }

    }
}
