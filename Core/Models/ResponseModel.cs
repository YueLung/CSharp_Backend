using System;
using System.Collections.Generic;
using System.Net;

namespace Core.Models
{
    public interface IResponseSucessModel
    {
        object Model { get; set; }
    }

    public interface IResponseHasPageModel : IResponseSucessModel
    {
        PaginationModel DataPage { get; set; }
    }

    public interface IResponseFailureModel
    {
        string Type { get; set; }
        IList<string> Errors { get; set; }
        object MoreErrors { get; set; }
        string ErrorMessage { get; set; }
    }

    #region 成功回應

    public class ResponseSucessModel : IResponseSucessModel
    {
        public object Model { get; set; }
    }

    public class ResponseHasPageModel : ResponseSucessModel, IResponseHasPageModel
    {
        public ResponseHasPageModel()
        {
            DataPage = new PaginationModel()
            {
                PageSize = 10,
                PageNumber = 1,
                TotalPages = 0,
                TotalRecord = 0,
            };
        }

        public PaginationModel DataPage { get; set; }
    }

    public class PaginationModel
    {
        public int PageSize { get; set; }
        public int PageNumber { get; set; }
        public int TotalPages { get; set; }
        public int TotalRecord { get; set; }
    }

    #endregion

    #region 失敗回應

    public enum BadRequestType
    {
        InvalidMode = 1,
        BadRequest = (int)HttpStatusCode.BadRequest
    }

    public class ResponseFailureModel : IResponseFailureModel
    {
        public string Type { get; set; }
        public IList<string> Errors { get; set; } = null;
        public object MoreErrors { get; set; } = null;
        public string ErrorMessage { get; set; } = null;
    }

    #endregion

    #region Swagger

    public interface IBadRequestForSwagger : IResponseSucessModel
    {
    }

    public interface IInternalServerErrorForSwagger
    {
        public string ErrorId { get; set; }
    }

    public interface IOkForSwagger<T> : IResponseSucessModel where T : class
    {
        public new T Model { get; set; }
    }

    public interface IOkHasPageForSwagger<T> : IResponseHasPageModel
    {
        public new T Model { get; set; }
        public new PaginationModel DataPage { get; set; }
    }

    #endregion
}
