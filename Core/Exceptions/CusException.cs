using System;
using System.Collections.Generic;
using System.Linq;

namespace Core.Exceptions
{
    public class CusException : Exception
    {
        #region Members

        private IList<string> _errors;
        private string _errorMsg;
        private IList<object> _morErrors;

        #endregion

        #region ctor

        public CusException() { }

        public CusException(string error) : this(new List<string>() { error })
        {
        }

        public CusException(IList<string> errors)
        {
            _errors = errors.Distinct().ToList();
        }

        public CusException(IList<string> errors, string errorMsg)
        {
            _errors = errors.Distinct().ToList();
            _errorMsg = errorMsg;
        }

        public CusException(IList<string> errors, IList<object> morErrors)
        {
            _errors = errors.Distinct().ToList();
            _morErrors = morErrors;
        }

        #endregion

        public IList<string> GetErrors() => _errors;

        public IList<object> GetMoreErrors() => _morErrors;

        public string GetErrorMsg() => _errorMsg;

    }
}
