using System;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using Core.Exceptions;
using Core.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace Backend.Middleware
{
    public class ErrorHandlerMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger _logger;
        public ErrorHandlerMiddleware(RequestDelegate next, ILoggerFactory loggerFactory)
        {
            _next = next;
            _logger = loggerFactory.CreateLogger<ErrorHandlerMiddleware>();
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception error)
            {
                var request = context.Request;
                var response = context.Response;
                var paths = request.Path.ToUriComponent();
                response.ContentType = "application/json";
                string result = string.Empty;

                var option = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };

                switch (error)
                {
                    case CusException e:
                        response.StatusCode = (int)HttpStatusCode.BadRequest;
                        var errorModel = new ResponseFailureModel
                        {
                            Type = BadRequestType.BadRequest.ToString(),
                            Errors = e.GetErrors(),
                            ErrorMessage = e.GetErrorMsg(),
                            MoreErrors = e.GetMoreErrors()
                        };
                        result = JsonSerializer.Serialize(errorModel, option);
                        break;
                    default:
                        _logger.LogError(error, $"Request { paths } Unhandled Error!");
                        response.StatusCode = (int)HttpStatusCode.InternalServerError;
                        result = JsonSerializer.Serialize(new
                        {
                            ErrorId = context.Connection.Id,
#if DEBUG
                            ErrorMsg = error.Message
#endif
                        }, option);

                        break;
                }

                await response.WriteAsync(result);
            }
        }
    }
}
