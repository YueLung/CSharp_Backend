using System;
using System.Net;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MediatR;
using Core.Models;


namespace Backend.Controllers
{
    [ApiController]
    public abstract class ApiControllerBase : ControllerBase
    {
        public IMediator _mediator { get; set; }

        public IActionResult Ok<TModel>(TModel model) => ApiActionResult.Ok(model);

    }

    public static class ApiActionResult
    {
        public static IActionResult Ok<TModel>(TModel model)
        {
            var result = new JsonResult(new SucessResponse()
            {
                Model = model
            });

            result.StatusCode = (int)HttpStatusCode.OK;

            return result;
        }
    }
}
