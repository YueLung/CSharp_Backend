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
    //[KeyNotFound]
    [ProducesResponseType((int)HttpStatusCode.OK)]
    [ProducesResponseType((int)HttpStatusCode.Unauthorized)]
    [ProducesResponseType((int)HttpStatusCode.Forbidden)]
    public abstract class ApiControllerBase : ControllerBase
    {
        public IMediator _mediator { get; set; }

        public IHttpContextAccessor HttpContextAccessor { get; set; }

        public Guid? CurrentUid
        {
            get
            {
                var userNmae = HttpContextAccessor?.HttpContext?.User?.Identity?.Name;

                Guid? userId = null;

                if (string.IsNullOrWhiteSpace(userNmae) && Guid.TryParse(userNmae, out var _tmp))
                    userId = _tmp;

                return userId;
            }
        }

        protected IActionResult Ok<TModel>(TModel model) => ApiActionResult.Ok(model);

        protected IActionResult BadRequest(string errorCode) => ApiActionResult.BadRequest(errorCode);

    }

    public static class ApiActionResult
    {
        public static IActionResult Ok<TModel>(TModel response)
        {
            if (response != null && response.GetType() == typeof(ResponseHasPageModel))
            {
                return new OkObjectResult(response);
            }

            var result = new JsonResult(new ResponseSucessModel()
            {
                Model = response
            });

            result.StatusCode = (int)HttpStatusCode.OK;

            return result;
        }

        public static IActionResult BadRequest(string errorCode, object moreErrors = null, string errorMessage = null)
        {
            return BadRequestErrorCodes(new List<string>() { errorCode }, moreErrors, errorMessage);
        }

        public static IActionResult BadRequestErrorCodes(List<string> errorCodes = null, object moreErrors = null, string errorMessage = null)
        {

            var model = new ResponseFailureModel()
            {
                Type = BadRequestType.BadRequest.ToString()
            };

            if (errorCodes != null) model.Errors = errorCodes;
            if (moreErrors != null) model.MoreErrors = moreErrors;
            if (!string.IsNullOrWhiteSpace(errorMessage)) model.ErrorMessage = errorMessage;

            return new JsonResult(model)
            {
                StatusCode = (int)HttpStatusCode.BadRequest
            };
        }
    }
}
